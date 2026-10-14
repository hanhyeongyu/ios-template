import SwiftUI
import DesignSystem

struct PriceText: View {

    private let price: Decimal
    private let style: AppFontStyle

    init(
        price: Decimal,
        style: AppFontStyle = .body2M
    ) {
        self.price = price
        self.style = style
    }

    var body: some View {
        Text(price, format: .currency(code: "KRW"))
            .font(style)
            .foregroundStyle(Color.textPrimary)
    }
}
