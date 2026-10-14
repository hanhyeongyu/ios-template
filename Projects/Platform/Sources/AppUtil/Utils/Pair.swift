import Foundation

public struct Pair<K: Hashable & Codable, V: Hashable & Codable>: Codable, Hashable {
    public let first: K
    public let second: V

    public init(_ first: K, _ second: V) {
        self.first = first
        self.second = second
    }

    public static func == (lhs: Pair<K, V>, rhs: Pair<K, V>) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
    }
}
