import Alamofire
import Networks
import CocoaLumberjackSwift

public let AUTHAPI: AuthApi = AuthApiImp.shared

public final class AuthApiImp : AuthApi {

    fileprivate static let shared: AuthApiImp = AuthApiImp()

    private init() {
        initSession()
    }

    public func send<T: APIRequest>(
        _ request: T ,
        completion: @escaping (T.Output?, Error?) -> Void
    ) {
        API.send(request, sessionType: .AuthApi, completion: completion)
    }

    public func send<T>(_ request: T) async throws -> T.Output where T : APIRequest {
        try await API.send(request, sessionType: .AuthApi)
    }
    
    public func send<T>(_ request: T) async throws -> T.Output where T : APIJSONRequest {
        try await API.send(request, sessionType: .AuthApi)
    }
    
    public func send<T>(_ request: T) async throws -> T.Output where T : APIDataRequest {
        try await API.send(request, sessionType: .AuthApi)
    }

    public func upload<T>(_ request: T) async throws -> T.Output where T : APIUploadRequest {
        try await API.upload(request, sessionType: .AuthApi)
    }
    
    public func download<T>(_ request: T) async throws -> T.Output where T : APIDownloadRequest {
        try await API.download(request, sessionType: .AuthApi)
    }
}

// MARK: Session
extension AuthApiImp {
    private func initSession() {
        let interceptor = Interceptor(
            adapter: AuthRequestAdapter(),
            retrier: AuthRequestRetrier()
        )
        let authApiSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        authApiSessionConfiguration.tlsMinimumSupportedProtocolVersion = .TLSv12
        API.addSession(type: .AuthApi, session: Session(configuration: authApiSessionConfiguration, interceptor: interceptor))
    }
}
