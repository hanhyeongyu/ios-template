import SwiftUI
import DesignSystem
import Shopping

struct ProductRow: View {

    private let product: Product
    private let onAdd: () -> Void

    init(
        product: Product,
        onAdd: @escaping () -> Void
    ) {
        self.product = product
        self.onAdd = onAdd
    }

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(product.name)
                    .font(.body1M)
                    .foregroundStyle(Color.textPrimary)

                PriceText(price: product.price, style: .body2R)
            }

            Spacer()

            Button(
                action: onAdd,
                label: {
                    AppIcon.plus
                }
            )
            .appButtonStyle(.outlined)
        }
        .padding(.vertical, AppSpacing.sm)
    }
}
