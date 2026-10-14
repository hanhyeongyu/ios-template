import SwiftUI

public struct AppToogleCircleCheckFillStyle: ToggleStyle {
    private var action: () -> Void

    public init(action: @escaping () -> Void = {}) {
        self.action = action
    }

    public func makeBody(configuration: Configuration) -> some View {
        Button(
            action: {
                configuration.isOn.toggle()
                action()
            },
            label: {
                HStack(spacing: 8.0) {
                    checkButtonIcon(isSelected: configuration.isOn)
                    configuration.label
                }
                .contentShape(Rectangle())
            }
        )
        .buttonStyle(.plain)
    }

    private func checkButtonIcon(isSelected: Bool) -> some View {
        ZStack {
            Circle()
                .fill(isSelected ? .green600 : .gray700)

            AppIcon.check
                .renderingMode(.template)
                .resizable()
                .frame(width: 7.0, height: 4.5)
                .foregroundStyle(isSelected ? .grayscaleBlack : .white)
                .blendMode(isSelected ? .destinationOut : .normal)
        }
        .compositingGroup()
        .frame(width: 16, height: 16)
    }
}

public struct AppToogleCircleCheckStyle: ToggleStyle {
    private var action: () -> Void

    public init(action: @escaping () -> Void = {}) {
        self.action = action
    }

    public func makeBody(configuration: Configuration) -> some View {
        Button(
            action: {
                configuration.isOn.toggle()
                action()
            },
            label: {
                HStack(spacing: 8.0) {
                    checkButtonIcon(isSelected: configuration.isOn)
                    configuration.label
                }
                .contentShape(Rectangle())
            }
        )
        .buttonStyle(.plain)
    }

    private func checkButtonIcon(isSelected: Bool) -> some View {
        ZStack {
            Circle()
                .stroke(isSelected ? .green600 : .gray400, lineWidth: 1.5)

            AppIcon.check
                .renderingMode(.template)
                .resizable()
                .frame(width: 7.0, height: 4.5)
                .foregroundStyle(isSelected ? .green600 : .gray400)
        }
        .frame(width: 16, height: 16)
    }
}

extension ToggleStyle where Self == AppToogleCircleCheckStyle {
    public static var circleCheck: AppToogleCircleCheckStyle {
        AppToogleCircleCheckStyle()
    }
}

extension ToggleStyle where Self == AppToogleCircleCheckFillStyle {
    public static var circleCheckFill: AppToogleCircleCheckFillStyle {
        AppToogleCircleCheckFillStyle()
    }
}

#Preview {
    VStack(spacing: 12) {
        HStack {
            Toggle("", isOn: .constant(false))
                .toggleStyle(.circleCheck)
            Text("Default")
            Spacer()
        }

        HStack {
            Toggle("", isOn: .constant(true))
                .toggleStyle(.circleCheck)
            Text("Actived")
            Spacer()
        }
        
        HStack {
            Toggle("", isOn: .constant(false))
                .toggleStyle(.circleCheckFill)
            Text("Default")
            Spacer()
        }

        HStack {
            Toggle("", isOn: .constant(true))
                .toggleStyle(.circleCheckFill)
            Text("Actived")
            Spacer()
        }
    }
    .foregroundStyle(.white)
    .padding()
    .background(.black)
}
