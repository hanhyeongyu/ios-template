import Foundation

public struct ErrorInfo: Codable {

    public let code: ApiFailureReason
    public let message: String

    init(
        code: ApiFailureReason,
        message: String
    ) {
        self.code = code
        self.message = message
    }
}
