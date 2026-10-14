import SwiftUI

extension UIApplication {
    public func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    public func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}
