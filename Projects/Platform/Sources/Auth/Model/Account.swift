import Foundation
import Preference

extension PreferenceKeys {
    fileprivate var id: PrefKey<String?> { .init(name: "kId", defaultValue: nil, encrypted: true) }
    fileprivate var password: PrefKey<String?> { .init(name: "kPassword", defaultValue: nil, encrypted: true) }
}

struct Account: Codable {
    let id: String
    let password: String
    
    public func save() {
        let preference = PreferenceStorage.shared
        preference.id = id
        preference.password = password
    }
    
    public func delete() {
        let preference = PreferenceStorage.shared
        preference.id = nil
        preference.password = nil
    }
    
    public static func shared() -> Account? {
        let preference = PreferenceStorage.shared
        guard let id = preference.id, let password = preference.password else { return nil}
        return Account(id: id, password: password)
    }
}
