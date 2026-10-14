import Foundation
import Alamofire

extension Error {
    public var isNetworkError: Bool {
        underlyingURLError?.isDeviceConnectionFailure ?? false
    }

    private var underlyingURLError: URLError? {
        if let urlError = self as? URLError {
            return urlError
        }
        return (self as? AFError)?.underlyingError as? URLError
    }
}

extension URLError {
    fileprivate var isDeviceConnectionFailure: Bool {
        switch code {
        case .notConnectedToInternet,
             .networkConnectionLost,
             .dataNotAllowed,
             .internationalRoamingOff:
            true
        default:
            false
        }
    }
}
