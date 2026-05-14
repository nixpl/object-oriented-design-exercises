import Fluent
import Vapor

struct ReviewFormData: Content {
    let text: String
    let rating: Int
    let product_id: UUID
}

struct ReviewContext: Encodable {
    let reviews: [Review]
    let products: [Product]
    let editId: UUID?
}

struct ReviewController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let reviews = routes.grouped("reviews")
        reviews.get(use: index)
        reviews.post(use: create)
        
        let viewRoutes = reviews.grouped("view")
        viewRoutes.get(use: renderIndex)
        viewRoutes.post(use: createFromForm)
        viewRoutes.post(":id", "edit", use: updateFromForm)
        viewRoutes.post(":id", "delete", use: deleteFromForm)
    }

    func index(req: Request) async throws -> [Review] {
        try await Review.query(on: req.db).with(\.$product).all()
    }

    func create(req: Request) async throws -> Review {
        let data = try req.content.decode(ReviewFormData.self)
        let review = Review(text: data.text, rating: data.rating, productID: data.product_id)
        try await review.save(on: req.db)
        return review
    }

    func renderIndex(req: Request) async throws -> View {
        let reviews = try await Review.query(on: req.db).with(\.$product).all()
        let products = try await Product.query(on: req.db).all()
        let editId = try? req.query.get(UUID.self, at: "edit")
        return try await req.view.render("reviews", ReviewContext(reviews: reviews, products: products, editId: editId))
    }

    func createFromForm(req: Request) async throws -> Response {
        let data = try req.content.decode(ReviewFormData.self)
        let review = Review(text: data.text, rating: data.rating, productID: data.product_id)
        try await review.save(on: req.db)
        return req.redirect(to: "/reviews/view")
    }

    func updateFromForm(req: Request) async throws -> Response {
        guard let review = try await Review.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        let data = try req.content.decode(ReviewFormData.self)
        review.text = data.text
        review.rating = data.rating
        review.$product.id = data.product_id
        try await review.save(on: req.db)
        return req.redirect(to: "/reviews/view")
    }

    func deleteFromForm(req: Request) async throws -> Response {
        guard let review = try await Review.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
        try await review.delete(on: req.db)
        return req.redirect(to: "/reviews/view")
    }
}
