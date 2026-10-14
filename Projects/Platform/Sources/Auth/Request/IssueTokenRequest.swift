import Foundation
import Networks

struct IssueTokenRequest: APIRequest {
    typealias Output = APIResponse<NetworkOAuthToken>
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeaders?

    init(
        email: String,
        password: String
    ) {
        self.endpoint = BaseURL.authBaseURL
        self.method = .post
        self.query = [
            "email": email,
            "password": password,
        ]
        self.header = nil
    }
}
