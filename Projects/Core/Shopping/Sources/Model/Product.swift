import Foundation

public struct Product: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let price: Decimal

    public init(
        id: UUID = UUID(),
        name: String,
        price: Decimal
    ) {
        self.id = id
        self.name = name
        self.price = price
    }
}
