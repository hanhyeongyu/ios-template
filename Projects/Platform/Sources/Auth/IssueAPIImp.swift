import Foundation
import Alamofire
import Networks

let ISSUEAPI: IssueApi = IssueApiImp.shared

final class IssueApiImp: IssueApi {
    
    fileprivate static let shared: IssueApiImp = IssueApiImp()

    private init() {
        initSession()
    }
    
    func send<T>(_ request: T, completion: @escaping (T.Output?, (any Error)?) -> Void) where T : APIRequest {
        API.send(request, sessionType: .IssueApi, completion: completion)
    }

    func send<T>(_ request: T) async throws -> T.Output where T : APIRequest {
        try await API.send(request, sessionType: .IssueApi)
    }
}

extension IssueApiImp {
    private func initSession() {
        let authApiSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        authApiSessionConfiguration.tlsMinimumSupportedProtocolVersion = .TLSv12
        API.addSession(type: .IssueApi, session: Session(configuration: authApiSessionConfiguration))
    }
}
