import Foundation
import Networks

/// Carries the access token to the token info endpoint so an invalid one is
/// reported before the app starts issuing its own requests. The body is not read.
struct CheckAccessTokenRequest: APIRequest {
    typealias Output = APIMessageResponse

    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeaders?

    init() {
        self.endpoint = BaseURL.authBaseURL
            .appendingPathComponent("info")
        self.method = .get
        self.query = [:]
        self.header = nil
    }
}
