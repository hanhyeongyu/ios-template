import Foundation
import SwiftUI

extension AppStorage {
    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Bool {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        let storedValue: Bool = PreferenceStorage.shared[dynamicMember: keyPath]
        self.init(wrappedValue: storedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Int {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        let storedValue: Int = PreferenceStorage.shared[dynamicMember: keyPath]
        self.init(wrappedValue: storedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Double {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        let storedValue: Double = PreferenceStorage.shared[dynamicMember: keyPath]
        self.init(wrappedValue: storedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == String {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        let storedValue: String = PreferenceStorage.shared[dynamicMember: keyPath]
        self.init(wrappedValue: storedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == URL {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        let storedValue: URL = PreferenceStorage.shared[dynamicMember: keyPath]
        self.init(wrappedValue: storedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Data {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        let storedValue: Data = PreferenceStorage.shared[dynamicMember: keyPath]
        self.init(wrappedValue: storedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }
}

extension AppStorage {

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Bool? {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self.init(key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Int? {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self.init(key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Double? {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self.init(key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == String? {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self.init(key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == URL? {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self.init(key.name, store: PreferenceStorage.shared.userDefaults)
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) where Value == Data? {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self.init(key.name, store: PreferenceStorage.shared.userDefaults)
    }
}
