public enum SignOutReason: String, Codable {
    case passwordChanged
    case tokenExpired
    case normal
}

public enum SessionEvent {
    case signedIn
    case signedOut(reason: SignOutReason?)
}
