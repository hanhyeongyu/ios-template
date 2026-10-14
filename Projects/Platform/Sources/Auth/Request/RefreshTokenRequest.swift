import Foundation
import Networks

struct RefreshTokenRequest: APIRequest {
    typealias Output = APIResponse<NetworkOAuthToken>
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeaders?

    init(refreshToken: String) {
        self.endpoint = BaseURL.authBaseURL
            .appendingPathComponent("refresh")
        self.method = .post
        self.query = ["refreshToken": refreshToken]
        self.header = nil
    }
}
