import Fluent
import Vapor

final class Review: Model, Content {
    static let schema = "reviews"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "text")
    var text: String

    @Field(key: "rating")
    var rating: Int

    @Parent(key: "product_id")
    var product: Product

    init() { }
    init(id: UUID? = nil, text: String, rating: Int, productID: UUID) {
        self.id = id
        self.text = text
        self.rating = rating
        self.$product.id = productID
    }
}
