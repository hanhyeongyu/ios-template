import Foundation

public struct CartItem: Identifiable, Hashable {
    public let product: Product
    public private(set) var quantity: Int

    public var id: Product.ID { product.id }
    public var subtotal: Decimal { product.price * Decimal(quantity) }

    public init(
        product: Product,
        quantity: Int = 1
    ) {
        self.product = product
        self.quantity = max(quantity, 1)
    }

    mutating func increase(by amount: Int = 1) {
        quantity += amount
    }

    mutating func decrease(by amount: Int = 1) {
        quantity = max(quantity - amount, 1)
    }
}
