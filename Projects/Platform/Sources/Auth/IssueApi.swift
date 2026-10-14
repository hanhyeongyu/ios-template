import Foundation
import Networks

protocol IssueApi {
    func send<T: APIRequest>(_ request: T, completion: @escaping (T.Output?, Error?) -> Void)
    func send<T: APIRequest>(_ request: T) async throws -> T.Output
}
