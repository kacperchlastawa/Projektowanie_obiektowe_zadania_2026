import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "Welcome to Vapor App"
    }

    try app.register(collection: ProductController())
    try app.register(collection: ProductWebController())
}
