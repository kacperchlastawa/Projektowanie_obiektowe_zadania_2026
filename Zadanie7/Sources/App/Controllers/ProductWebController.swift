import Vapor
import Fluent
import Leaf

struct ProductWebController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("web", "products")
        products.get(use: index)
        products.get("create", use: createHandler)
        products.post("create", use: createPostHandler)
        products.group(":productID") { product in
            product.get(use: show)
            product.get("edit", use: editHandler)
            product.post("edit", use: editPostHandler)
            product.post("delete", use: deleteHandler)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).all()
        return try await req.view.render("products/index", ["products": products])
    }
    
    @Sendable
    func createHandler(req: Request) async throws -> View {
        return try await req.view.render("products/create")
    }
    
    @Sendable
    func createPostHandler(req: Request) async throws -> Response {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return req.redirect(to: "/web/products")
    }
    
    @Sendable
    func show(req: Request) async throws -> View {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("products/show", ["product": product])
    }
    
    @Sendable
    func editHandler(req: Request) async throws -> View {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("products/edit", ["product": product])
    }
    
    @Sendable
    func editPostHandler(req: Request) async throws -> Response {
        let updatedProduct = try req.content.decode(Product.self)
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        product.name = updatedProduct.name
        product.price = updatedProduct.price
        product.description = updatedProduct.description
        try await product.save(on: req.db)
        return req.redirect(to: "/web/products/\(product.id!)")
    }
    
    @Sendable
    func deleteHandler(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return req.redirect(to: "/web/products")
    }
}
