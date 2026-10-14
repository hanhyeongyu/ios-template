import Foundation

// MARK: Request
public protocol APIRequest {
    associatedtype Output: Decodable

    var endpoint: URL { get }
    var method: HTTPMethod { get }
    var query: QueryItems { get }
    var header: HTTPHeaders? { get }
}

public protocol APIJSONRequest {
    associatedtype Output: Decodable
    
    var endpoint: URL { get }
    var method: HTTPMethod { get }
    var body: Encodable & Sendable { get }
    var header: HTTPHeaders? { get }
}

public protocol APIDataRequest {
    associatedtype Output: Decodable
    
    var endpoint: URL { get }
    var method: HTTPMethod { get }
    var body: Data { get }
    var header: HTTPHeaders? { get }
}

public protocol APIUploadRequest: APIRequest {
    var file: UploadFiles { get }
}

public protocol APIDownloadRequest: APIRequest where Output == URL {
//    let fileName: String { get }
//    let fileExtention: String { get }
}
