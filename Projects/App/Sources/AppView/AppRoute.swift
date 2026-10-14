import SwiftUI
import DesignSystem

enum AppRoute: Hashable, CaseIterable {
    case cart
}

extension TabBarDestination where Route == AppRoute {
    static let cart = TabBarDestination(
        title: "Cart",
        selectedIcon: Image(systemName: "cart.fill"),
        unSelectedIcon: Image(systemName: "cart"),
        route: .cart
    )
}
