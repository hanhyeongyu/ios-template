import Foundation
import Alamofire

public struct HTTPHeaders: ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {
    private var storage: [String: String] = [:]

    public init() {}

    public init(_ headers: [HTTPHeader]) {
        headers.forEach { storage[$0.name] = $0.value }
    }

    public init(arrayLiteral elements: HTTPHeader...) {
        elements.forEach { storage[$0.name] = $0.value }
    }

    public init(dictionaryLiteral elements: (String, String)...) {
        elements.forEach { storage[$0.0] = $0.1 }
    }

    public init(_ dict: [String: String]) {
        self.storage = dict
    }

    public subscript(key: String) -> String? {
        get { storage[key] }
        set { storage[key] = newValue }
    }

    public var dictionary: [String: String] {
        storage
    }

    public mutating func add(_ header: HTTPHeader) {
        storage[header.name] = header.value
    }
}

extension Alamofire.HTTPHeaders {
    init?(_ httpHeaders: HTTPHeaders?) {
        guard let headers = httpHeaders else { return nil }
        self.init(headers.dictionary)
    }
}

public struct HTTPHeader: Hashable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public extension HTTPHeader {
    static func authorization(bearerToken: String) -> HTTPHeader {
        HTTPHeader(name: "Authorization", value: "Bearer \(bearerToken)")
    }

    static func authorization(username: String, password: String) -> HTTPHeader {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()
        return HTTPHeader(name: "Authorization", value: "Basic \(credential)")
    }

    static func contentType(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Type", value: value)
    }

    static func accept(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept", value: value)
    }
}
