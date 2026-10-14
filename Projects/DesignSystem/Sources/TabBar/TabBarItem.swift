import SwiftUI

public extension View {
    func appTabItem<Route: Hashable>(
        selection: Route,
        destination: TabBarDestination<Route>
    ) -> some View {
        self.tabItem {
            selection == destination.route ? destination.selectedIcon : destination.unSelectedIcon
            Text(destination.title)
                .font(.callout)
        }
        .tag(destination.route)
    }
}
