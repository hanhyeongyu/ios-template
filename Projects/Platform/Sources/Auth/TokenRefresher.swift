import Foundation
import UIKit
import Networks

/// Carries the access token to the server when the app comes to the foreground.
/// A dead token answers with an invalid token error, which the retrier refreshes on.
@MainActor
public final class TokenRefresher {

    public static let shared: TokenRefresher = TokenRefresher()

    private let coolTime: TimeInterval = 60.0 * 60.0 * 6.0
    private var updatedAt: Date?

    private nonisolated init() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            Task { await self?.didBecomeActiveForRefreshToken(notification) }
        }
    }

    /// Touching the shared instance is what installs the observer.
    public func register() {
    }
}

extension TokenRefresher {

    private func didBecomeActiveForRefreshToken(_ notification: Notification) async {
        guard OAuthToken.shared() != nil else { return }
        guard shouldRefreshToken() else { return }

        await cat()
        updatedAt = Date.now
    }

    private func shouldRefreshToken() -> Bool {
        guard let updatedAt = updatedAt else { return true }
        return Date.now.timeIntervalSince(updatedAt) >= coolTime
    }

    private func cat() async {
        _ = try? await AUTHAPI.send(CheckAccessTokenRequest())
    }
}
