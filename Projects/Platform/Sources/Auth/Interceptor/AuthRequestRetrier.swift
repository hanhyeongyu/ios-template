import Foundation
import AppUtil
import Alamofire
import CocoaLumberjackSwift
import Networks

public final class AuthRequestRetrier : RequestInterceptor {
    public typealias Request = Alamofire.Request
    private var requestsToRetry: [(RetryResult) -> Void] = []
    private var isRefreshing = false
    private let errorLock = NSLock()
    private let retryLimit = 3

    public init() {
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        errorLock.lock() ; defer { errorLock.unlock() }

        var logString = "request retrier:"

        guard let error = API.getError(error: error) else {
            DDLogError("\(logString)\n not handled error -> pass through \n\n")
            completion(.doNotRetry)
            return
        }

        switch(error.getApiError().reason) {
        case .ExpiredAccessToken, .InvalidAccessToken:

            logString = "\(logString)\n reason:\(error)\n token: \(String(describing: OAuthToken.shared()))"
            DDLogDebug("\(logString)\n\n")

            if request.retryCount >= retryLimit {
                DDLogError(" retry limit exceeded. retry aborted.\n\n")
                completion(.doNotRetryWithError(error))
                return
            }

            guard let token = OAuthToken.shared() else {
                let apiError = AppError(reason: .TokenNotFound)
                DDLogError(" refresh token not exist. retry aborted.\n\n")
                DDLogError(" should not refresh: \(apiError)  -> pass through \n")
                completion(.doNotRetryWithError(apiError))
                return
            }

            // if let urlString = request.request?.url?.absoluteString, urlString.hasSuffix(Paths.checkAccessToken) == false {
            //     requestsToRetry.append(completion)
            // }
            requestsToRetry.append(completion)

            if !isRefreshing {
                isRefreshing = true

                // SdkLog.d("<<<<<<<<<<<<<< start token refresh\n request: \(String(describing:request))\n\n")
                token.refresh { [unowned self] (_, error) in
                    self.errorLock.lock() ; defer { self.errorLock.unlock() }

                    if let error = error {
                        // token refresh failure.
                        DDLogError("\(logString) refreshToken error: \(error). retry aborted.\n request: \(request) \n\n")

                        self.signOutIfTokenUnrecoverable(dueTo: error, token: token)

                        // pending requests all cancel
                        self.requestsToRetry.forEach {
                            $0(.doNotRetryWithError(error))
                        }
                    } else {
                        // token refresh success.
                        DDLogDebug(">>>>>>>>>>>>>> refreshToken success\n request: \(request) \n\n")
                        // proceed all pending requests.
                        self.requestsToRetry.forEach {
                            $0(.retry)
                        }
                    }
                    self.requestsToRetry.removeAll() // reset all stored completion
                    self.isRefreshing = false
                }
            }
        default:
            DDLogError("\(logString)\n reason:\(error)\n not handled error -> pass through \n\n")
            completion(.doNotRetryWithError(error))
        }
    }
}

extension AuthRequestRetrier {

    /// Only a dead refresh token ends the session. Network or server failures keep it for a later retry.
    private func signOutIfTokenUnrecoverable(dueTo error: Error, token: OAuthToken) {
        let apiError = error as? AppError ?? API.getError(error: error)
        guard let reason = apiError?.getApiError().reason, reason.isRefreshTokenUnusable else {
            DDLogDebug(" refresh failed without a refresh token error. session kept.\n\n")
            return
        }

        Task { @MainActor in
            token.expire(reason: .tokenExpired)
        }
    }
}
