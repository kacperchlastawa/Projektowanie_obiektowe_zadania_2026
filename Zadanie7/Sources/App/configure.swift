import Vapor
import Fluent
import FluentSQLiteDriver
import Leaf

public func configure(_ app: Application) async throws {
    // Enable Leaf
    app.views.use(.leaf)

    // Setup SQLite DB
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Register migrations
    app.migrations.add(CreateProduct())

    // Auto migrate on startup
    try await app.autoMigrate()

    // Register routes
    try routes(app)
}
