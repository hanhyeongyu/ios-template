import SwiftUI
import DesignSystem
import Shopping

public struct CartView: View {

    @State private var cart: ShoppingCart = ShoppingCart()

    public init() {
    }

    public var body: some View {
        NavigationStack {
            List {
                productSection
                cartSection
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.surfaceBase)
            .navigationTitle("Shopping")
            .navigationStyle(scheme: .dark)
            .safeAreaInset(edge: .bottom) {
                checkoutBar
            }
        }
    }

    private var productSection: some View {
        Section {
            ForEach(Product.samples) { product in
                ProductRow(product: product) {
                    cart.add(product)
                }
                .listRowBackground(Color.surfaceBase)
            }
        } header: {
            SectionHeader(title: "Products")
        }
    }

    @ViewBuilder
    private var cartSection: some View {
        if !cart.isEmpty {
            Section {
                ForEach(cart.items) { item in
                    CartItemRow(
                        item: item,
                        onIncrease: { cart.add(item.product) },
                        onDecrease: { cart.decrease(item.product) }
                    )
                    .listRowBackground(Color.surfaceBase)
                }
            } header: {
                SectionHeader(title: "Cart")
            }
        }
    }

    private var checkoutBar: some View {
        HStack(spacing: AppSpacing.md) {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text("\(cart.totalQuantity) items")
                    .font(.caption1R)
                    .foregroundStyle(Color.textSecondary)

                PriceText(price: cart.totalPrice, style: .h4)
            }

            Spacer()

            Button(
                action: cart.clear,
                label: {
                    Text("Clear")
                }
            )
            .appButtonStyle(cart.isEmpty ? .filledDisabled : .filled)
            .disabled(cart.isEmpty)
        }
        .padding(AppSpacing.md)
        .background(Color.surfaceL1)
    }
}

#Preview {
    CartView()
}
