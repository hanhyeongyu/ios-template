import Foundation

public struct APIResponse<Data: Decodable>: Decodable {
    public let status: Int
    public let message: String
    public let data: Data

    public init(
        status: Int,
        message: String,
        data: Data
    ) {
        self.status = status
        self.message = message
        self.data = data
    }
}

public struct APIMessageResponse: Decodable {
    public let status: Int
    public let message: String
}
