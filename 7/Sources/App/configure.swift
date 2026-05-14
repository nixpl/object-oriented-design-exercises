import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.migrations.add(CreateCategory())
    app.migrations.add(CreateProduct())
    app.migrations.add(CreateReview())
    app.views.use(.leaf)
    try routes(app)
}
