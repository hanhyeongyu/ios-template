import Foundation
import AppUtil
import Alamofire

public protocol Api: AnyObject {
    func send<T: APIRequest>(_ request: T , sessionType: SessionType, completion: @escaping (T.Output?, Error?) -> Void)
    func send<T: APIRequest>(_ request: T , sessionType: SessionType) async throws -> T.Output
    func send<T: APIJSONRequest>(_ request: T , sessionType: SessionType) async throws -> T.Output
    func send<T: APIDataRequest>(_ request: T , sessionType: SessionType) async throws -> T.Output
    func upload<T: APIUploadRequest>(_ request: T, sessionType: SessionType) async throws -> T.Output
    func download<T: APIDownloadRequest>(_ request: T, sessionType: SessionType) async throws -> T.Output
    func addSession(type: SessionType, session: Session)
}

// MARK: HTTPMethod
public enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case query = "QUERY"
    case trace = "TRACE"
}

extension Alamofire.HTTPMethod {
    init(_ httpMethod: HTTPMethod) {
        self.init(rawValue: httpMethod.rawValue)
    }
}

extension HTTPMethod {
    func encoder() -> ParameterEncoding {
        switch self {
        case .get, .head, .delete:
            return Alamofire.URLEncoding.default
        default:
            return Alamofire.JSONEncoding.default
        }
    }
}

// MARK: Session
public enum SessionType {
    case Api
    case AuthApi    // Token (withRetrier)
    case IssueApi
}
