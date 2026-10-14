import Foundation

public protocol ParameterEncodable {
    func encode(to encoder: ParameterEncoder)
}

public final class ParameterEncoder {
    private let parameterContainer = ParameterContainer()
    public init() {}

    public func container() -> ParameterContainer { parameterContainer }

    public func encode(_ encodable: ParameterEncodable) -> Data {
        encodable.encode(to: self)
        let result =  parameterContainer.build().data(using: .utf8)!
        parameterContainer.clear()
        return result
    }
}

public final class ParameterContainer {
    private var parts: [String] = []

    public init() {}

    // MARK: - Primitives

    // [Nub]
    public func encode<T: LosslessStringConvertible>(_ value: T, forKey key: String) {
        parts.append("\"\(escape(key))\":\(String(value))")
    }
    
    public func encode(_ value: Bool, forKey key: String) {
        parts.append("\"\(escape(key))\":\(value ? "true" : "false")")
    }

    public func encodeNil(forKey key: String) {
        parts.append("\"\(escape(key))\":null")
    }

    // MARK: - String

    public func encodeString(_ value: String, forKey key: String) {
        parts.append("\"\(escape(key))\":\"\(escape(value))\"")
    }

    // [Nub]
    public func encodeStrings(_ values: [String], forKey key: String) {
        let joined = values.map { "\"\(escape($0))\"" }.joined(separator: ",")
        parts.append("\"\(escape(key))\":[\(joined)]")
    }

    // [Num...]
    public func encode<T: LosslessStringConvertible>(_ values: [T], forKey key: String) {
        let joined = values.map { String($0) }.joined(separator: ",")
        parts.append("\"\(escape(key))\":[\(joined)]")
    }

    // [Bool]
    public func encode(_ values: [Bool], forKey key: String) {
        let joined = values.map { $0 ? "true" : "false" }.joined(separator: ",")
        parts.append("\"\(escape(key))\":[\(joined)]")
    }

    // Optional helper
    public func encodeIfPresent(_ value: String?, forKey key: String) {
        if let v = value { encodeString(v, forKey: key) }
    }
    public func encodeIfPresent<T: LosslessStringConvertible>(_ value: T?, forKey key: String) {
        if let v = value { encode(v, forKey: key) }
    }
    public func encodeIfPresent(_ value: Bool?, forKey key: String) {
        if let v = value { encode(v, forKey: key) }
    }

    // MARK: - Nested

    public func encode(_ encodable: ParameterEncodable, forKey key: String) {
        let nestedEncoder = ParameterEncoder()
        encodable.encode(to: nestedEncoder)
        let nestedJson = nestedEncoder.container().build()
        parts.append("\"\(escape(key))\":\(nestedJson)")
    }
    
    public func encode(_ values: [ParameterEncodable], forKey key: String) {
        let jsons = values.map { v -> String in
            let ne = ParameterEncoder()
            v.encode(to: ne)
            return ne.container().build()
        }.joined(separator: ",")
        parts.append("\"\(escape(key))\":[\(jsons)]")
    }

    // dic
    public func encode(_ dict: [String: String], forKey key: String) {
        let body = dict
            .map { "\"\(escape($0.key))\":\"\(escape($0.value))\"" }
            .joined(separator: ",")
        parts.append("\"\(escape(key))\":{\(body)}")
    }

    // MARK: - Build

    public func build() -> String {
        "{\(parts.joined(separator: ","))}"
    }

    // MARK: - JSON escape
    private func escape(_ s: String) -> String {
        var out = ""
        out.reserveCapacity(s.count)
        for ch in s.unicodeScalars {
            switch ch {
            case "\"": out.append("\\\"")
            case "\\": out.append("\\\\")
            case "/":  out.append("\\/")
            case "\u{08}": out.append("\\b")
            case "\u{0C}": out.append("\\f")
            case "\n": out.append("\\n")
            case "\r": out.append("\\r")
            case "\t": out.append("\\t")
            default:
                if ch.value < 0x20 {
                    let hex = String(ch.value, radix: 16, uppercase: true)
                    out.append("\\u" + String(repeating: "0", count: 4 - hex.count) + hex)
                } else {
                    out.unicodeScalars.append(ch)
                }
            }
        }
        return out
    }
    
    func clear() {
        parts.removeAll()
    }
}
