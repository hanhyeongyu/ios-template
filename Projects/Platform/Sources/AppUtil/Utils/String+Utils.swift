import Foundation

public extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: "")
    }

    func localizedWithFormat(bundle: Bundle = .main, tableName: String = "Localizable", arguments: CVarArg...) -> String {
        return String(format: self.localized(bundle: bundle, tableName: tableName), arguments: arguments)
    }
}

extension String {
    public var forceCharWrapping: String {
        self.map { String($0) }.joined(separator: "\u{200B}")
    }
}
