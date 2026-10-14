import SwiftUI
import DesignSystem
import Cart

struct AppView: View {

    @State private var route: AppRoute = .cart

    var body: some View {
        TabView(selection: $route) {
            CartView()
                .appTabItem(selection: route, destination: .cart)
        }
    }
}
