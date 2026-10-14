import SwiftUI

public enum AppFontStyle {
    public typealias PretendardVariable = DesignSystemFontFamily.PretendardVariable
    
    case h1         // 28px, Bold, 140%
    case h2         // 24px, Bold, 140%
    case h3         // 20px, SemiBold, 140%
    case h4         // 18px, SemiBold, 140%
    case body1M     // 16px, Medium, 140%
    case body1R     // 16px, Regular, 140%
    case body2M     // 14px, Medium, 140%
    case body2R     // 14px, Regular, 140%
    case body3M     // 14px, Medium, 140%
    case caption1B  // 12px, Bold, 140%
    case caption1R  // 12px, Regular, 140%
    case caption2   // 10px, Medium, 120%

    public var font: Font {
        switch self {
        case .h1: PretendardVariable.bold.size(28)
        case .h2: PretendardVariable.bold.size(24)
        case .h3: PretendardVariable.semiBold.size(20)
        case .h4: PretendardVariable.semiBold.size(18)
        case .body1M: PretendardVariable.medium.size(16)
        case .body1R: PretendardVariable.regular.size(16)
        case .body2M: PretendardVariable.medium.size(14)
        case .body2R: PretendardVariable.regular.size(14)
        case .body3M: PretendardVariable.medium.size(14)
        case .caption1B: PretendardVariable.bold.size(12)
        case .caption1R: PretendardVariable.regular.size(12)
        case .caption2: PretendardVariable.medium.size(10)
        }
    }

    public var uiFont: UIFont {
        switch self {
        case .h1: PretendardVariable.bold.font(size: 28)
        case .h2: PretendardVariable.bold.font(size: 24)
        case .h3: PretendardVariable.semiBold.font(size: 20)
        case .h4: PretendardVariable.semiBold.font(size: 18)
        case .body1M: PretendardVariable.medium.font(size: 16)
        case .body1R: PretendardVariable.regular.font(size: 16)
        case .body2M: PretendardVariable.medium.font(size: 14)
        case .body2R: PretendardVariable.regular.font(size: 14)
        case .body3M: PretendardVariable.medium.font(size: 14)
        case .caption1B: PretendardVariable.bold.font(size: 12)
        case .caption1R: PretendardVariable.regular.font(size: 12)
        case .caption2: PretendardVariable.medium.font(size: 10)
        }
    }

    public var lineHeight: CGFloat {
        switch self {
        case .h1, .h2, .h3, .h4, .body1M, .body1R, .body2M, .body2R, .body3M, .caption1B, .caption1R:
            return 1.4  // 140%
        case .caption2:
            return 1.2  // 120%
        }
    }
}

extension Text {
    public func font(_ style: AppFontStyle) -> some View {
        self
            .font(style.font)
            .lineSpacing(style.lineHeight * 0.4)
    }
}

extension View {
    public func font(_ style: AppFontStyle) -> some View {
        self
            .font(style.font)
    }
}

extension DesignSystemFontConvertible {
    public func size(_ size: CGFloat) -> SwiftUI.Font {
        swiftUIFont(size: size)
    }
}
