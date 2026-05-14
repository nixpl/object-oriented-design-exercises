import Fluent

struct CreateReview: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("reviews")
            .id()
            .field("text", .string, .required)
            .field("rating", .int, .required)
            .field("product_id", .uuid, .required, .references("products", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("reviews").delete()
    }
}
