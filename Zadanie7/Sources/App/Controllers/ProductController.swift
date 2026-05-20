import Vapor
import Fluent

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.post(use: create)
        products.group(":productID") { product in
            product.get(use: show)
            product.put(use: update)
            product.delete(use: delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [Product] {
        try await Product.query(on: req.db).with(\.$category).all()
    }

    struct ProductDTO: Content {
        var name: String
        var price: Double
        var description: String
        var category_id: UUID
    }

    @Sendable
    func create(req: Request) async throws -> Product {
        let data = try req.content.decode(ProductDTO.self)
        let product = Product(name: data.name, price: data.price, description: data.description, categoryID: data.category_id)
        try await product.save(on: req.db)
        return product
    }

    @Sendable
    func show(req: Request) async throws -> Product {
        guard let product = try await Product.query(on: req.db).filter(\.$id == req.parameters.get("productID")!).with(\.$category).first() else {
            throw Abort(.notFound)
        }
        return product
    }

    @Sendable
    func update(req: Request) async throws -> Product {
        let data = try req.content.decode(ProductDTO.self)
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        product.name = data.name
        product.price = data.price
        product.description = data.description
        product.$category.id = data.category_id
        try await product.save(on: req.db)
        return product
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .noContent
    }
}
