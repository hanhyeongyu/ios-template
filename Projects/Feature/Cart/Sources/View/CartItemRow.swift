import SwiftUI
import DesignSystem
import Shopping

struct CartItemRow: View {

    private let item: CartItem
    private let onIncrease: () -> Void
    private let onDecrease: () -> Void

    init(
        item: CartItem,
        onIncrease: @escaping () -> Void,
        onDecrease: @escaping () -> Void
    ) {
        self.item = item
        self.onIncrease = onIncrease
        self.onDecrease = onDecrease
    }

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(item.product.name)
                    .font(.body1M)
                    .foregroundStyle(Color.textPrimary)

                PriceText(price: item.subtotal, style: .body2R)
            }

            Spacer()

            HStack(spacing: AppSpacing.sm) {
                Button(action: onDecrease) {
                    AppIcon.remove
                }

                Text("\(item.quantity)")
                    .font(.body1M)
                    .foregroundStyle(Color.textPrimary)
                    .frame(minWidth: AppSpacing.lg)

                Button(action: onIncrease) {
                    AppIcon.plus
                }
            }
            .buttonStyle(.plain)
            .foregroundStyle(Color.textSecondary)
        }
        .padding(.vertical, AppSpacing.sm)
    }
}
