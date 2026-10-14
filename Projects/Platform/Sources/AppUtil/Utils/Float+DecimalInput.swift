import Foundation

public extension Float {
    init?(decimalInput text: String) {
        guard let number = Formatter.decimalInputFormatter.number(from: text) else { return nil }
        self = number.floatValue
    }

    var decimalInput: String {
        Formatter.decimalInputFormatter.string(for: self) ?? "\(self)"
    }
}
