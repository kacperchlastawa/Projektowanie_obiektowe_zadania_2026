import Vapor
import Fluent
import FluentSQLiteDriver
import Leaf
import Redis

public func configure(_ app: Application) async throws {
    // Enable Leaf
    app.views.use(.leaf)

    // Setup SQLite DB
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Register migrations
    app.migrations.add(CreateCategory())
    app.migrations.add(CreateProduct())

    // Auto migrate on startup
    try await app.autoMigrate()

    // Configure Redis
    app.redis.configuration = try RedisConfiguration(hostname: "redis", port: 6379)

    // Register routes
    try routes(app)
}
