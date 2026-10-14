import SwiftUI

@propertyWrapper
public struct CodableAppStorage<Value: Codable>: DynamicProperty {
    
    @AppStorage private var data: Data?

    private let defaultValue: Value

    public var wrappedValue: Value {
        get {
            guard let data = data else { return defaultValue }
            return (try? JSONDecoder().decode(Value.self, from: data)) ?? defaultValue
        }
        nonmutating set {
            data = try? JSONEncoder().encode(newValue)
        }
    }

    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(_ keyPath: KeyPath<PreferenceKeys, PreferenceStorage.Key<Value>>) {
        let key = PreferenceStorage.shared.prefKeys[keyPath: keyPath]
        self._data = AppStorage(key.name, store: PreferenceStorage.shared.userDefaults)
        self.defaultValue = key.defaultValue
    }
}
