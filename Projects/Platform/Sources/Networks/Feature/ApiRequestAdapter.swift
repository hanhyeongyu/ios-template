import Foundation
import Alamofire

public class ApiRequestAdapter : RequestInterceptor {
    private let header: String

    public init(header: String = "AppHeader") {
        self.header = header
    }

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let urlRequest = urlRequest
        // urlRequest.setValue(header, forHTTPHeaderField: "HeaderField")
        return completion(.success(urlRequest))
    }
}
