import Fluent
import Vapor

struct ProductFormData: Content {
    let name: String
    let price: Double
    let category_id: UUID
}

struct ProductContext: Encodable {
    let products: [Product]
    let categories: [Category]
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
        try await Product.query(on: req.db).with(\.$category).all()
    }

    func create(req: Request) async throws -> Product {
        let data = try req.content.decode(ProductFormData.self)
        let product = Product(name: data.name, price: data.price, categoryID: data.category_id)
        try await product.save(on: req.db)
        return product
    }

    func renderIndex(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).with(\.$category).all()
        let categories = try await Category.query(on: req.db).all()
        let editId = try? req.query.get(UUID.self, at: "edit")
        return try await req.view.render("products", ProductContext(products: products, categories: categories, editId: editId))
    }

    func createFromForm(req: Request) async throws -> Response {
        let data = try req.content.decode(ProductFormData.self)
        let product = Product(name: data.name, price: data.price, categoryID: data.category_id)
        try await product.save(on: req.db)
        return req.redirect(to: "/products/view")
    }

    func updateFromForm(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        let data = try req.content.decode(ProductFormData.self)
        product.name = data.name
        product.price = data.price
        product.$category.id = data.category_id
        try await product.save(on: req.db)
        return req.redirect(to: "/products/view")
    }

    func deleteFromForm(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        try await product.delete(on: req.db)
        return req.redirect(to: "/products/view")
    }
}
