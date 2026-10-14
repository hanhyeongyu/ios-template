import Foundation

public enum StorageError: Error {
    case CoreDataFailed(reason: CoreDataError, errorMessage: String?)
}

public enum CoreDataError {
    case Unknown
    case BatchInsertError
}

extension StorageError {
    public init(reason: CoreDataError = .Unknown, message:String? = nil) {
        switch reason {
        case .Unknown:
            self = .CoreDataFailed(reason: reason, errorMessage: message ?? "unkown error.")
        case .BatchInsertError:
            self = .CoreDataFailed(reason: reason, errorMessage: message ?? "batch insert error.")
        }
    }
}
