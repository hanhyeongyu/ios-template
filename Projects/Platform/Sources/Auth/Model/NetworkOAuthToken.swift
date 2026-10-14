import Foundation

struct NetworkOAuthToken: Decodable {
    let tokenType: String
    let accessToken: String
    let expiresInMillis: Int
    let refreshToken: String
    let refreshExpiresInMillis: Int

    func oauthToken() -> OAuthToken {
        OAuthToken(
            accessToken: accessToken,
            expiresIn: Date.now.addingTimeInterval(TimeInterval(expiresInMillis) / 1000.0),
            refreshToken: refreshToken,
            refreshExpiresIn: Date.now.addingTimeInterval(TimeInterval(refreshExpiresInMillis) / 1000.0),
            tokenType: tokenType
        )
    }

    enum CodingKeys: String, CodingKey {
        case tokenType
        case accessToken
        case expiresInMillis = "expiresIn"
        case refreshToken
        case refreshExpiresInMillis = "refreshExpiresIn"
    }
}
