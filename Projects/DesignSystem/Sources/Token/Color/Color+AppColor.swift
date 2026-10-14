import SwiftUI

extension Color {
    // MARK: - Surface
    /// #0B0E14
    public static let surfaceBase = DesignSystemAsset.base.swiftUIColor
    /// #151A23
    public static let surfaceL1 = DesignSystemAsset.l1.swiftUIColor
    /// #1F2633
    public static let surfaceL2 = DesignSystemAsset.l2.swiftUIColor
    /// #323B49
    public static let surfaceL3 = DesignSystemAsset.l3.swiftUIColor
    /// #323D4F
    public static let surfaceBaseD1 = DesignSystemAsset.surfaceBaseD1.swiftUIColor

    // MARK: - Text
    /// #F6F8FA
    public static let textPrimary = DesignSystemAsset.textPrimary.swiftUIColor
    /// #EAEEF4
    public static let textSecondary = DesignSystemAsset.textSecondary.swiftUIColor
    /// #B2BAC8
    public static let textTertiary = DesignSystemAsset.textTertiary.swiftUIColor
    /// #6C798F
    public static let textDisabled = DesignSystemAsset.textDisabled.swiftUIColor

    // MARK: - Border
    /// #4A576D
    public static let borderDefault = DesignSystemAsset.borderDefault.swiftUIColor

    // MARK: - Gray
    /// #FFFFFF
    public static let grayscaleWhite = DesignSystemAsset.white.swiftUIColor
    /// #151515
    public static let grayscaleBlack = DesignSystemAsset.black.swiftUIColor
    /// #F8FAFC
    public static let gray50 = DesignSystemAsset.gray50.swiftUIColor
    /// #F0F3F7
    public static let gray100 = DesignSystemAsset.gray100.swiftUIColor
    /// #DCE2E9
    public static let gray200 = DesignSystemAsset.gray200.swiftUIColor
    /// #BAC3D0
    public static let gray300 = DesignSystemAsset.gray300.swiftUIColor
    /// #8A96A8
    public static let gray400 = DesignSystemAsset.gray400.swiftUIColor
    /// #647083
    public static let gray500 = DesignSystemAsset.gray500.swiftUIColor
    /// #475161
    public static let gray600 = DesignSystemAsset.gray600.swiftUIColor
    /// #323B49
    public static let gray700 = DesignSystemAsset.gray700.swiftUIColor
    /// #1F2633
    public static let gray800 = DesignSystemAsset.gray800.swiftUIColor
    /// #151A23
    public static let gray900 = DesignSystemAsset.gray900.swiftUIColor
    /// #0B0E14
    public static let gray950 = DesignSystemAsset.gray950.swiftUIColor

    // MARK: - Red
    /// #FF5656
    public static let red300 = DesignSystemAsset.red300.swiftUIColor
    /// #FF5656
    public static let red400 = DesignSystemAsset.red400.swiftUIColor
    /// #DC3545
    public static let red500 = DesignSystemAsset.red500.swiftUIColor

    // MARK: - Green
    /// #E6FAF3
    public static let green50 = DesignSystemAsset.green50.swiftUIColor
    /// #CCF5E3
    public static let green100 = DesignSystemAsset.green100.swiftUIColor
    /// #99EBCB
    public static let green200 = DesignSystemAsset.green200.swiftUIColor
    /// #66DBB5
    public static let green300 = DesignSystemAsset.green300.swiftUIColor
    /// #33CC9E
    public static let green400 = DesignSystemAsset.green400.swiftUIColor
    /// #00B88D
    public static let green500 = DesignSystemAsset.green500.swiftUIColor
    /// #009B77
    public static let green600 = DesignSystemAsset.green600.swiftUIColor
    /// #007A5B
    public static let green700 = DesignSystemAsset.green700.swiftUIColor
    /// #005C45
    public static let green800 = DesignSystemAsset.green800.swiftUIColor
    /// #003D2E
    public static let green900 = DesignSystemAsset.green900.swiftUIColor
    /// #00221A
    public static let green950 = DesignSystemAsset.green950.swiftUIColor

    // MARK: - Color
    /// #288CE8
    public static let blue300 = DesignSystemAsset.blue300.swiftUIColor
    /// #EAD200
    public static let yellow300 = DesignSystemAsset.yellow300.swiftUIColor
    /// #F06E25
    public static let orange500 = DesignSystemAsset.orange500.swiftUIColor
    /// #D23C84
    public static let pink300 = DesignSystemAsset.pink300.swiftUIColor

    // MARK: - SNS
    /// #00C73C
    public static let snsNaver = DesignSystemAsset.naver.swiftUIColor
    /// #FDDC3F
    public static let snsKakao = DesignSystemAsset.kakao.swiftUIColor

    // MARK: - Opacity
    /// #009B77 10%
    public static let green600Op10 = DesignSystemAsset.green600Op10.swiftUIColor
}

public extension ShapeStyle where Self == Color {
    // MARK: - Surface
    static var surfaceBase: Color { .surfaceBase }
    static var surfaceL1: Color { .surfaceL1 }
    static var surfaceL2: Color { .surfaceL2 }
    static var surfaceL3: Color { .surfaceL3 }
    static var surfaceBaseD1: Color { .surfaceBaseD1 }

    // MARK: - Text
    static var textPrimary: Color { .textPrimary }
    static var textSecondary: Color { .textSecondary }
    static var textTertiary: Color { .textTertiary }
    static var textDisabled: Color { .textDisabled }

    // MARK: - Border
    static var borderDefault: Color { .borderDefault }

    // MARK: - Gray
    static var grayscaleWhite: Color { .grayscaleWhite }
    static var grayscaleBlack: Color { .grayscaleBlack }
    static var gray50: Color { .gray50 }
    static var gray100: Color { .gray100 }
    static var gray200: Color { .gray200 }
    static var gray300: Color { .gray300 }
    static var gray400: Color { .gray400 }
    static var gray500: Color { .gray500 }
    static var gray600: Color { .gray600 }
    static var gray700: Color { .gray700 }
    static var gray800: Color { .gray800 }
    static var gray900: Color { .gray900 }
    static var gray950: Color { .gray950 }

    // MARK: - Red
    static var red300: Color { .red300 }
    static var red400: Color { .red400 }
    static var red500: Color { .red500 }

    // MARK: - Green
    static var green50: Color { .green50 }
    static var green100: Color { .green100 }
    static var green200: Color { .green200 }
    static var green300: Color { .green300 }
    static var green400: Color { .green400 }
    static var green500: Color { .green500 }
    static var green600: Color { .green600 }
    static var green700: Color { .green700 }
    static var green800: Color { .green800 }
    static var green900: Color { .green900 }
    static var green950: Color { .green950 }

    // MARK: - Color
    static var colorBlue: Color { .blue300 }
    static var colorYellow: Color { .yellow300 }
    static var orange500: Color { .orange500 }
    static var colorPink: Color { .pink300 }

    // MARK: - SNS
    static var snsNaver: Color { .snsNaver }
    static var snsKakao: Color { .snsKakao }

    // MARK: - Opacity
    static var green600Op10: Color { .green600Op10 }
}
