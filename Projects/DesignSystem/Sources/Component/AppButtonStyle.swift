import SwiftUI

public enum AppButtonStyle {
    case filled
    case filledDisabled
    case outlined
    case text
}

extension Button {
    public func appButtonStyle(_ style: AppButtonStyle) -> some View {
        modifier(AppButtonStyleModifier(style: style))
    }
}

struct AppButtonStyleModifier: ViewModifier {
    let style: AppButtonStyle

    func body(content: Content) -> some View {
        switch style {
        case .filled:
            content
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .font(AppFontStyle.body1M.font)
                .foregroundColor(Color.grayscaleWhite)
                .background(Color.green500)
                .cornerRadius(8)
                .tint(.white)

        case .filledDisabled:
            content
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .font(AppFontStyle.body1M.font)
                .foregroundColor(.gray300)
                .background(.gray700)
                .cornerRadius(8)
                .tint(.gray300)

        case .outlined:
            content
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .font(AppFontStyle.body1M.font)
                .foregroundColor(.gray400)
                .background(.surfaceBase, in: RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray400, lineWidth: 1)
                )
                .tint(.white)

        case .text:
            content
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .font(AppFontStyle.body1M.font)
                .foregroundColor(Color.grayscaleWhite)
                .tint(.white)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        // Filled
        VStack(alignment: .leading, spacing: 8) {
            Text("Filled")
                .font(AppFontStyle.h4.font)
                .foregroundColor(Color.grayscaleWhite)

            Button(
                action: {},
                label: {
                    Text("로그인")
                }
            )
            .appButtonStyle(.filled)

            Button(
                action: {},
                label: {
                    HStack(spacing: 10) {
                        Image(systemName: "eye")
                        Spacer()
                        Text("로그인")
                        Spacer()
                    }
                }
            )
            .appButtonStyle(.filled)
        }

        // Filled Disabled
        VStack(alignment: .leading, spacing: 8) {
            Text("Filled Disabled")
                .font(AppFontStyle.h4.font)
                .foregroundColor(Color.grayscaleWhite)

            Button(
                action: {},
                label: {
                    Text("로그인")
                }
            )
            .appButtonStyle(.filledDisabled)

            Button(
                action: {},
                label: {
                    HStack(spacing: 10) {
                        Image(systemName: "eye")
                        Spacer()
                        Text("로그인")
                        Spacer()
                    }
                }
            )
            .appButtonStyle(.filledDisabled)
        }

        // Outlined
        VStack(alignment: .leading, spacing: 8) {
            Text("Outlined")
                .font(AppFontStyle.h4.font)
                .foregroundColor(Color.grayscaleWhite)

            Button(
                action: {},
                label: {
                    Text("로그인")
                }
            )
            .appButtonStyle(.outlined)

            Button(
                action: {},
                label: {
                    HStack(spacing: 10) {
                        Image(systemName: "eye")
                        Spacer()
                        Text("로그인")
                        Spacer()
                    }
                }
            )
            .appButtonStyle(.outlined)
        }

        // Text
        VStack(alignment: .leading, spacing: 8) {
            Text("Text")
                .font(AppFontStyle.h4.font)
                .foregroundColor(Color.grayscaleWhite)

            Button(
                action: {},
                label: {
                    Text("로그인")
                }
            )
            .appButtonStyle(.text)

            Button(
                action: {},
                label: {
                    HStack(spacing: 10) {
                        Image(systemName: "eye")
                        Spacer()
                        Text("로그인")
                        Spacer()
                    }
                }
            )
            .appButtonStyle(.text)
        }
    }
    .padding()
    .background(.surfaceBase)
}
