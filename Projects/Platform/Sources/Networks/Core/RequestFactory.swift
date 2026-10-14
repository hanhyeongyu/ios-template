import Foundation
import AppUtil

final class RequestFactory {
    
    let method: HTTPMethod
    let body: Data?
    let headers: [String: String]
    private var urlComponents: URLComponents?

    init(request: any APIDataRequest) {
        
        self.method = request.method
        self.body = request.body
        self.headers = request.header?.dictionary ?? [:]
        self.urlComponents = URLComponents(url: request.endpoint, resolvingAgainstBaseURL: true)
    }

    func urlRequestRepresentation() throws -> URLRequest {
        try makeURLRequest(httpBody: body)
    }

    private func makeURLRequest(httpBody: Data? = nil) throws -> URLRequest {
        guard let url = urlComponents?.url else {
            throw AppError(reason: .NotSupported)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = httpBody
        return urlRequest
    }
}
