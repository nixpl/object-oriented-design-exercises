import Fluent
import Vapor

struct CategoryContext: Encodable {
    let categories: [Category]
    let editId: UUID?
}

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.get(use: index)
        categories.post(use: create)
        
        let viewRoutes = categories.grouped("view")
        viewRoutes.get(use: renderIndex)
        viewRoutes.post(use: createFromForm)
        viewRoutes.post(":id", "edit", use: updateFromForm)
        viewRoutes.post(":id", "delete", use: deleteFromForm)
    }

    func index(req: Request) async throws -> [Category] {
        try await Category.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Category {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        return category
    }

    func renderIndex(req: Request) async throws -> View {
        let categories = try await Category.query(on: req.db).all()
        let editId = try? req.query.get(UUID.self, at: "edit")
        return try await req.view.render("categories", CategoryContext(categories: categories, editId: editId))
    }

    func createFromForm(req: Request) async throws -> Response {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        return req.redirect(to: "/categories/view")
    }

    func updateFromForm(req: Request) async throws -> Response {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        let updated = try req.content.decode(Category.self)
        category.name = updated.name
        try await category.save(on: req.db)
        return req.redirect(to: "/categories/view")
    }

    func deleteFromForm(req: Request) async throws -> Response {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        try await category.delete(on: req.db)
        return req.redirect(to: "/categories/view")
    }
}
