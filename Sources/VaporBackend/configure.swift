import Vapor
import Fluent
import FluentSQLiteDriver


/// configures your application
func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //Controllers
    try app.register(collection: UserController())
    try app.register(collection: GroupController())
    
    //Database connection
    app.databases.use(.sqlite(.file("/Volumes/Volumes/sqlite/app.db")), as: .sqlite)
}
