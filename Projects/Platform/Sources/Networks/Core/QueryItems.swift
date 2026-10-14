import Foundation
import Alamofire

public typealias QueryItems = [String: Any]

public final class URLEncoding {
    
    public static let `default` = URLEncoding()
    
    internal func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
       
    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        Alamofire.URLEncoding.default.queryComponents(fromKey: key, value: value)
    }
}

extension URL {
    public func appending(parameters: [String: Any]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }

        let query = URLEncoding.default.query(parameters)
        let percentEncodedQuery = (components.percentEncodedQuery.map { $0 + "&" } ?? "") + query
        components.percentEncodedQuery = percentEncodedQuery
        return components.url ?? self
    }
}
