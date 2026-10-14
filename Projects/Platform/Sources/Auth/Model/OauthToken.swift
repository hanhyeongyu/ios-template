import Foundation
import Event
import AppUtil
import Preference
import Networks

public struct OAuthToken: Codable {

    public let accessToken: String
    public let expiresIn: Date

    public let refreshToken: String
    public let refreshExpiresIn: Date

    public let tokenType: String

    public static func shared() -> OAuthToken? {
        PreferenceStorage.shared.token
    }

    public static func issue(
        email: String,
        password: String
    ) async throws -> OAuthToken {
        // issue token
        let request = IssueTokenRequest(email: email, password: password)
        let token = try await ISSUEAPI.send(request).data
            .oauthToken()

        // save token
        let account = Account(id: email, password: password)
        account.save()

        await MainActor.run {
            PreferenceStorage.shared.token = token
            PreferenceStorage.shared.isSignIn = true
            EventPublisher.shared.publish(SessionEvent.signedIn)
        }

        return token
    }

    public func refresh(
        completion:@escaping (OAuthToken?, Error?) -> Void
    ) {
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        ISSUEAPI.send(request) { output, error in
            if let error = error {
                completion(nil, error)
                return
            }

            if let token = output?.data.oauthToken() {
                PreferenceStorage.shared.token = token
                completion(token,  nil)
            } else {
                completion(nil, AppError())
            }
        }
    }

    @MainActor
    public func expire(reason: SignOutReason? = nil) {
        let wasSignedIn = PreferenceStorage.shared.isSignIn
        PreferenceStorage.shared.token = nil
        PreferenceStorage.shared.isSignIn = false

        Account.shared()?.delete()
        if wasSignedIn {
            EventPublisher.shared.publish(SessionEvent.signedOut(reason: reason))
        }
    }
}
