import Fluent
import Vapor

final class Product: Model, Content, @unchecked Sendable {
    static let schema = "products"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "price")
    var price: Double

    @Field(key: "description")
    var description: String

    @Parent(key: "category_id")
    var category: Category

    init() { }

    init(id: UUID? = nil, name: String, price: Double, description: String, categoryID: Category.IDValue) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.$category.id = categoryID
    }
}
