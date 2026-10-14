import Foundation
import Networks

public protocol AuthApi {
    func send<T: APIRequest>(_ request: T, completion: @escaping (T.Output?, Error?) -> Void)
    func send<T: APIRequest>(_ request: T) async throws -> T.Output
    func send<T: APIJSONRequest>(_ request: T) async throws -> T.Output
    func send<T: APIDataRequest>(_ request: T) async throws -> T.Output
    func upload<T: APIUploadRequest>(_ request: T) async throws -> T.Output
    func download<T: APIDownloadRequest>(_ request: T) async throws -> T.Output
}
