import Foundation

public extension FloatingPoint where Self: CVarArg {
    /// 소수점 최대 2자리까지 표시 (trailing zero 제거)
    /// - e.g. 2.0 → "2", 2.5 → "2.5", 2.15 → "2.15"
    func formatted(maxFraction: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxFraction
        return formatter.string(for: self) ?? "\(self)"
    }
}
