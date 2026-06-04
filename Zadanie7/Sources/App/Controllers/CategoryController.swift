import Vapor
import Fluent
import Redis

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.get(use: index)
        categories.post(use: create)
        categories.group(":categoryID") { category in
            category.get(use: show)
            category.put(use: update)
            category.delete(use: delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [Category] {
        if let cached = try await req.redis.get("categories", asJSON: [Category].self) {
            req.logger.info("Pobrano z Redis Cache!")
            return cached
        }
        let categories = try await Category.query(on: req.db).all()
        try await req.redis.set("categories", toJSON: categories)
        return categories
    }

    @Sendable
    func create(req: Request) async throws -> Category {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        _ = try await req.redis.delete("categories")
        return category
    }

    @Sendable
    func show(req: Request) async throws -> Category {
        guard let category = try await Category.query(on: req.db).filter(\.$id == req.parameters.get("categoryID")!).with(\.$products).first() else {
            throw Abort(.notFound)
        }
        return category
    }

    @Sendable
    func update(req: Request) async throws -> Category {
        let updatedCategory = try req.content.decode(Category.self)
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        category.name = updatedCategory.name
        try await category.save(on: req.db)
        _ = try await req.redis.delete("categories")
        _ = try await req.redis.delete("products")
        return category
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        _ = try await req.redis.delete("categories")
        _ = try await req.redis.delete("products")
        return .noContent
    }
}
