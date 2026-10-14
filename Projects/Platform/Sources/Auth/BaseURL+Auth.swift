import Foundation
import Networks

extension BaseURL {
    static var authBaseURL: URL = baseURL
        .appendingPathComponent("member")
        .appendingPathComponent("issue")
}
