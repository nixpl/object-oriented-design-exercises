import Fluent
import Vapor

struct ProductContext: Encodable {
    let products: [Product]
    let editId: UUID?
}

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.post(use: create)
        
        let viewRoutes = products.grouped("view")
        viewRoutes.get(use: renderIndex)
        viewRoutes.post(use: createFromForm)
        viewRoutes.post(":id", "edit", use: updateFromForm)
        viewRoutes.post(":id", "delete", use: deleteFromForm)
    }

    func index(req: Request) async throws -> [Product] {
        try await Product.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Product {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return product
    }

    func renderIndex(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).all()
        let editId = try? req.query.get(UUID.self, at: "edit")
        let context = ProductContext(products: products, editId: editId)
        return try await req.view.render("products", context)
    }

    func createFromForm(req: Request) async throws -> Response {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return req.redirect(to: "/products/view")
    }

    func updateFromForm(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        let updated = try req.content.decode(Product.self)
        product.name = updated.name
        product.price = updated.price
        try await product.save(on: req.db)
        return req.redirect(to: "/products/view")
    }

    func deleteFromForm(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        try await product.delete(on: req.db)
        return req.redirect(to: "/products/view")
    }
}
