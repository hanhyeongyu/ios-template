import Foundation
import Observation

@Observable
public final class ShoppingCart {

    public private(set) var items: [CartItem]

    public var totalQuantity: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    public var totalPrice: Decimal {
        items.reduce(Decimal.zero) { $0 + $1.subtotal }
    }

    public var isEmpty: Bool {
        items.isEmpty
    }

    public init(items: [CartItem] = []) {
        self.items = items
    }

    public func add(_ product: Product) {
        if let index = indexOf(product) {
            items[index].increase()
        } else {
            items.append(CartItem(product: product))
        }
    }

    public func remove(_ product: Product) {
        items.removeAll { $0.product == product }
    }

    public func decrease(_ product: Product) {
        guard let index = indexOf(product) else { return }

        if items[index].quantity == 1 {
            items.remove(at: index)
        } else {
            items[index].decrease()
        }
    }

    public func clear() {
        items.removeAll()
    }

    private func indexOf(_ product: Product) -> Int? {
        items.firstIndex { $0.product == product }
    }
}
