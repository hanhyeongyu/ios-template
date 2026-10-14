import Foundation

/// App All Error
public enum AppError : Error {

    /// App 내에서 발생하는 클라이언트 에러
    case ClientFailed(reason: ClientFailureReason, errorMessage: String?)

    /// API 호출 에러
    case ApiFailed(reason: ApiFailureReason, errorInfo: ErrorInfo?)
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        if self.isClientFailed {
            let clientError = self.getClientError()
            return clientError.message
        } else {
            let apiError = self.getApiError()
            return "Api Error code: \(apiError.reason.rawValue)"
        }
    }
}

/// :nodoc:
extension AppError {
    public init(reason:ClientFailureReason = .Unknown, message:String? = nil) {
        switch reason {
        case .Cancelled:
            self = .ClientFailed(reason: reason, errorMessage:message ?? "user cancelled")
        case .NotSupported:
            self = .ClientFailed(reason: reason, errorMessage: "target app is not installed.")
        case .BadParameter:
            self = .ClientFailed(reason: reason, errorMessage:message ?? "bad parameters.")
        case .TokenNotFound:
            self = .ClientFailed(reason: reason, errorMessage: message ?? "authentication tokens not exist.")
        case .CastingFailed:
            self = .ClientFailed(reason: reason, errorMessage: message ?? "casting failed.")
        case .Unknown:
            self = .ClientFailed(reason: reason, errorMessage:message ?? "unknown error.")
        }
    }
}

/// :nodoc:
extension AppError {
    public init?(response:HTTPURLResponse, data:Data) {
        if 200 ..< 300 ~= response.statusCode {
            return nil
        }

        if let errorInfo = try? AppJSONDecoder.custom.decode(ErrorInfo.self, from: data) {
            self = .ApiFailed(reason: errorInfo.code, errorInfo: errorInfo)
        } else {
            return nil
        }
    }

    public init(apiFailedMessage:String? = nil) {
        self = .ApiFailed(
            reason: .Unknown,
            errorInfo: ErrorInfo(code: .Unknown, message: apiFailedMessage ?? "Unknown error")
        )
    }
}

// helper
extension AppError {
    public var isClientFailed : Bool {
        if case .ClientFailed = self {
            return true
        }
        return false
    }

    public var isApiFailed : Bool {
        if case .ApiFailed = self {
            return true
        }
        return false
    }

    public func getClientError() -> (reason:ClientFailureReason, message:String?) {
        if case let .ClientFailed(reason, message) = self {
            return (reason, message)
        }
        return (ClientFailureReason.Unknown, nil)
    }

    public func getApiError() -> (reason:ApiFailureReason, info:ErrorInfo?) {
        if case let .ApiFailed(reason, info) = self {
            return (reason, info)
        }
        return (ApiFailureReason.Unknown, nil)
    }

    public func isInvalidTokenError() -> Bool {
        isApiFailed && getApiError().reason.isAccessTokenUnusable
    }
}

// MARK: - error code enu
/// 클라이언트 에러 종류 입니다.
public enum ClientFailureReason {
    /// 기타 에러
    case Unknown

    /// 사용자의 취소 액션 등
    case Cancelled

    /// API 요청에 사용할 토큰이 없음
    case TokenNotFound

    /// 지원되지 않는 기능
    case NotSupported

    /// 잘못된 파라미터
    case BadParameter

    /// type casting 실패
    case CastingFailed
}

/// API 서버 에러 종류 입니다. 서버 `ErrorCode`의 `errorCode`와 같은 값을 씁니다.
public enum ApiFailureReason : Int, Codable {

    /// 알 수 없는 서버 에러
    case Unknown = -9999

    /// 일시적인 서버 에러
    case SystemError = 5000

    /// 서버가 현재 요청을 처리할 수 없음
    case ServiceUnavailable = 5030

    /// 잘못된 파라미터
    case InvalidParameter = 4000

    /// 잘못된 상태값
    case IllegalStatus = 4001

    /// 존재하지 않는 엔티티
    case EntityNotFound = 4040

    /// 허용되지 않는 method
    case MethodNotAllowed = 4050

    /// 중복 요청
    case DuplicateRequest = 4090

    /// 요청 크기 초과
    case PayloadTooLarge = 4130

    /// 지원하지 않는 media type
    case UnsupportedMediaType = 4150

    /// 요청에 토큰이 없음
    case TokenNotFound = 4010

    /// access token 만료
    case ExpiredAccessToken = 4011

    /// refresh token 만료
    case ExpiredRefreshToken = 4012

    /// access token이 잘못됨
    case InvalidAccessToken = 4013

    /// refresh token이 잘못됨
    case InvalidRefreshToken = 4014

    /// 계정 정보가 맞지 않음
    case InvalidPassword = 4015

    /// 접근 권한이 없음
    case AccessDenied = 4030
}

/// :nodoc:
extension ApiFailureReason {
    public init(from decoder: Decoder) throws {
        self = try ApiFailureReason(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .Unknown
    }
}

extension ApiFailureReason {
    /// The access token cannot be used as is, but a refresh may recover it.
    public var isAccessTokenUnusable: Bool {
        self == .ExpiredAccessToken || self == .InvalidAccessToken
    }

    /// The refresh token is dead, so the session cannot be recovered.
    public var isRefreshTokenUnusable: Bool {
        self == .ExpiredRefreshToken || self == .InvalidRefreshToken
    }
}

extension Error {
    public var asAppError: AppError? {
        self as? AppError
    }

    public func hasApiFailureReason(_ reason: ApiFailureReason) -> Bool {
        guard let appError = self.asAppError else { return false }
        return appError.getApiError().reason == reason
    }
}
