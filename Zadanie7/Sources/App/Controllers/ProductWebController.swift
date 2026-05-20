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
        let products = try await Product.query(on: req.db).with(\.$category).all()
        return try await req.view.render("products/index", ["products": products])
    }
    
    @Sendable
    func createHandler(req: Request) async throws -> View {
        let categories = try await Category.query(on: req.db).all()
        struct Context: Encodable {
            let categories: [Category]
        }
        return try await req.view.render("products/create", Context(categories: categories))
    }
    
    struct CreateProductData: Content {
        var name: String
        var price: Double
        var description: String
        var category_id: UUID
    }
    
    @Sendable
    func createPostHandler(req: Request) async throws -> Response {
        let data = try req.content.decode(CreateProductData.self)
        let product = Product(name: data.name, price: data.price, description: data.description, categoryID: data.category_id)
        try await product.save(on: req.db)
        return req.redirect(to: "/web/products")
    }
    
    @Sendable
    func show(req: Request) async throws -> View {
        guard let product = try await Product.query(on: req.db).filter(\.$id == req.parameters.get("productID")!).with(\.$category).first() else {
            throw Abort(.notFound)
        }
        return try await req.view.render("products/show", ["product": product])
    }
    
    @Sendable
    func editHandler(req: Request) async throws -> View {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let categories = try await Category.query(on: req.db).all()
        struct Context: Encodable {
            let product: Product
            let categories: [Category]
        }
        return try await req.view.render("products/edit", Context(product: product, categories: categories))
    }
    
    @Sendable
    func editPostHandler(req: Request) async throws -> Response {
        let data = try req.content.decode(CreateProductData.self)
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        product.name = data.name
        product.price = data.price
        product.description = data.description
        product.$category.id = data.category_id
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
