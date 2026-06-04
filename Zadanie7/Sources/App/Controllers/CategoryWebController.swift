import Vapor
import Fluent
import Leaf

struct CategoryWebController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("web", "categories")
        categories.get(use: index)
        categories.get("create", use: createHandler)
        categories.post("create", use: createPostHandler)
        categories.group(":categoryID") { category in
            category.get(use: show)
            category.get("edit", use: editHandler)
            category.post("edit", use: editPostHandler)
            category.post("delete", use: deleteHandler)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        let categories: [Category]
        if let cached = try await req.redis.get("categories", asJSON: [Category].self) {
            req.logger.info("Web: Pobrano z Redis Cache!")
            categories = cached
        } else {
            categories = try await Category.query(on: req.db).all()
            try await req.redis.set("categories", toJSON: categories)
        }
        return try await req.view.render("categories/index", ["categories": categories])
    }
    
    @Sendable
    func createHandler(req: Request) async throws -> View {
        return try await req.view.render("categories/create")
    }
    
    @Sendable
    func createPostHandler(req: Request) async throws -> Response {
        let data = try req.content.decode(Category.self)
        try await data.save(on: req.db)
        _ = try await req.redis.delete("categories")
        return req.redirect(to: "/web/categories")
    }
    
    @Sendable
    func show(req: Request) async throws -> View {
        guard let category = try await Category.query(on: req.db).filter(\.$id == req.parameters.get("categoryID")!).with(\.$products).first() else {
            throw Abort(.notFound)
        }
        return try await req.view.render("categories/show", ["category": category])
    }
    
    @Sendable
    func editHandler(req: Request) async throws -> View {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("categories/edit", ["category": category])
    }
    
    @Sendable
    func editPostHandler(req: Request) async throws -> Response {
        let updatedCategory = try req.content.decode(Category.self)
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        category.name = updatedCategory.name
        try await category.save(on: req.db)
        _ = try await req.redis.delete("categories")
        _ = try await req.redis.delete("products")
        return req.redirect(to: "/web/categories/\(category.id!)")
    }
    
    @Sendable
    func deleteHandler(req: Request) async throws -> Response {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        _ = try await req.redis.delete("categories")
        _ = try await req.redis.delete("products")
        return req.redirect(to: "/web/categories")
    }
}
