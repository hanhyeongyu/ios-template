import XCTest
@testable import Shopping

final class ShoppingCartTests: XCTestCase {

    private let apple = Product(name: "Apple", price: 1_500)
    private let bread = Product(name: "Bread", price: 3_000)

    func test_whenCartIsCreated_shouldBeEmpty() {
        let cart = ShoppingCart()

        XCTAssertTrue(cart.isEmpty)
        XCTAssertEqual(cart.totalPrice, .zero)
    }

    func test_whenProductIsAdded_shouldHoldOneItemWithQuantityOne() {
        let cart = ShoppingCart()

        cart.add(apple)

        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 1)
    }

    func test_whenSameProductIsAddedTwice_shouldIncreaseQuantityInsteadOfAppending() {
        let cart = ShoppingCart()

        cart.add(apple)
        cart.add(apple)

        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 2)
    }

    func test_whenCartHasSeveralProducts_shouldSumQuantityAndPrice() {
        let cart = ShoppingCart()

        cart.add(apple)
        cart.add(apple)
        cart.add(bread)

        XCTAssertEqual(cart.totalQuantity, 3)
        XCTAssertEqual(cart.totalPrice, 6_000)
    }

    func test_whenQuantityIsDecreasedBelowOne_shouldRemoveTheItem() {
        let cart = ShoppingCart()
        cart.add(apple)

        cart.decrease(apple)

        XCTAssertTrue(cart.isEmpty)
    }

    func test_whenQuantityIsDecreasedAboveOne_shouldKeepTheItem() {
        let cart = ShoppingCart()
        cart.add(apple)
        cart.add(apple)

        cart.decrease(apple)

        XCTAssertEqual(cart.items.first?.quantity, 1)
    }

    func test_whenProductIsRemoved_shouldDropEveryQuantityOfIt() {
        let cart = ShoppingCart()
        cart.add(apple)
        cart.add(apple)
        cart.add(bread)

        cart.remove(apple)

        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.totalPrice, 3_000)
    }

    func test_whenCartIsCleared_shouldBeEmpty() {
        let cart = ShoppingCart()
        cart.add(apple)
        cart.add(bread)

        cart.clear()

        XCTAssertTrue(cart.isEmpty)
    }
}
