import SwiftUI

public struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func sheetCornerRadius(_ cornerRadius: CGFloat) -> some View {
        self.modifier(CornerRadiusViewModifier(cornerRadius: cornerRadius))
    }
}

private struct CornerRadiusViewModifier: ViewModifier {

    private let cornerRadius: CGFloat

    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }

    func body(content: Content) -> some View {
        content
            .presentationCornerRadius(cornerRadius)
    }
}
