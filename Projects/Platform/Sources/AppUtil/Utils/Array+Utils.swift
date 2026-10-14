import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}

public extension Array where Element: BinaryFloatingPoint {
    func average() -> Double {
        return isEmpty ? 0.0 : Double(reduce(0, +)) / Double(count)
    }
}
