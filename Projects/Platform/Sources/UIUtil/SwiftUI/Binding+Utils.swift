import SwiftUI
import os

extension Binding {
  /// Creates a binding by projecting the base optional value to a Boolean value.
  ///
  /// Writing `false` to the binding will `nil` out the base value. Writing `true` produces a
  /// runtime warning.
  ///
  /// - Parameter base: A value to project to a Boolean value.
  public init<V>(
    _ base: Binding<V?>,
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) where Value == Bool {
    self =
      base[
        fileID: HashableStaticString(rawValue: fileID),
        filePath: HashableStaticString(rawValue: filePath),
        line: line,
        column: column
      ]
  }
}

extension Optional {
  fileprivate subscript(
    fileID fileID: HashableStaticString,
    filePath filePath: HashableStaticString,
    line line: UInt,
    column column: UInt
  ) -> Bool {
    get { self != nil }
    set {
      if newValue {
          os_log(
          """
          Boolean presentation binding attempted to write 'true' to a generic 'Binding<Item?>'
          (i.e., 'Binding<\(Wrapped.self)?>').

          This is not valid because there is no way to convert 'true' into an instance of '\(Wrapped.self)'.
          """
        )
      } else {
        self = nil
      }
    }
  }
}

extension Binding {
    /// Creates a binding by projecting the base value to an unwrapped value.
    ///
    /// Useful for producing non-optional bindings from optional ones.
    ///
    /// > Note: SwiftUI comes with an equivalent failable initializer, `Binding.init(_:)`, but using
    /// > it can lead to crashes at runtime. [Feedback][FB8367784] has been filed, but in the meantime
    /// > this initializer exists as a workaround.
    ///
    /// [FB8367784]: https://gist.github.com/stephencelis/3a232a1b718bab0ae1127ebd5fcf6f97
    ///
    /// - Parameter base: A value to project to an unwrapped value.
    public init?(unwrapping base: Binding<Value?>) {
        guard let value = base.wrappedValue else { return nil }
        self.init(unwrapping: base, default: value)
    }
    
    public init(unwrapping base: Binding<Value?>, default value: Value) {
        self = base[default: DefaultSubscript(value)]
    }
    
    /// Creates a binding that ignores writes to its wrapped value when equivalent to the new value.
    ///
    /// Useful to minimize writes to bindings passed to SwiftUI APIs. For example, [`NavigationLink`
    /// may write `nil` twice][FB9404926] when dismissing its destination via the navigation bar's
    /// back button. Logic attached to this dismissal will execute twice, which may not be desirable.
    ///
    /// [FB9404926]: https://gist.github.com/mbrandonw/70df235e42d505b3b1b9b7d0d006b049
    ///
    /// - Parameter isDuplicate: A closure to evaluate whether two elements are equivalent, for
    ///   purposes of filtering writes. Return `true` from this closure to indicate that the second
    ///   element is a duplicate of the first.
    public func removeDuplicates(
        by isDuplicate: @Sendable @escaping (Value, Value) -> Bool
    ) -> Self where Value: Sendable {
        .init(
            get: { self.wrappedValue },
            set: { newValue, transaction in
                guard !isDuplicate(self.wrappedValue, newValue) else { return }
                self.transaction(transaction).wrappedValue = newValue
            }
        )
    }
}

extension Binding where Value: Equatable, Value: Sendable {
    /// Creates a binding that ignores writes to its wrapped value when equivalent to the new value.
    ///
    /// Useful to minimize writes to bindings passed to SwiftUI APIs. For example, [`NavigationLink`
    /// may write `nil` twice][FB9404926] when dismissing its destination via the navigation bar's
    /// back button. Logic attached to this dismissal will execute twice, which may not be desirable.
    ///
    /// [FB9404926]: https://gist.github.com/mbrandonw/70df235e42d505b3b1b9b7d0d006b049
    public func removeDuplicates() -> Self {
        self.removeDuplicates(by: { $0 == $1 })
    }
}

extension Optional {
    fileprivate subscript(default defaultSubscript: DefaultSubscript<Wrapped>) -> Wrapped {
        get {
            defaultSubscript.value = self ?? defaultSubscript.value
            return defaultSubscript.value
        }
        set {
            defaultSubscript.value = newValue
            if self != nil { self = newValue }
        }
    }
}

private final class DefaultSubscript<Value>: Hashable {
    var value: Value
    init(_ value: Value) {
        self.value = value
    }
    static func == (lhs: DefaultSubscript, rhs: DefaultSubscript) -> Bool {
        lhs === rhs
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

struct HashableStaticString: Hashable {
  var rawValue: StaticString

  init(rawValue: StaticString) {
    self.rawValue = rawValue
  }

  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.rawValue.description == rhs.rawValue.description
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(rawValue.description)
  }
}
