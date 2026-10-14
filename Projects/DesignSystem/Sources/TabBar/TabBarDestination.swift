import SwiftUI

public struct TabBarDestination<Route: Hashable> {
    public let title: String
    public let selectedIcon: Image
    public let unSelectedIcon: Image
    public let route: Route

    public init(
        title: String,
        selectedIcon: Image,
        unSelectedIcon: Image,
        route: Route
    ) {
        self.title = title
        self.selectedIcon = selectedIcon
        self.unSelectedIcon = unSelectedIcon
        self.route = route
    }
}
