import Foundation
import AppUtil
import Alamofire

extension Api {
    public func getError(error: Error) -> AppError? {
        if let aferror = error as? AFError {
            switch aferror {
            case .responseValidationFailed(let reason):
                switch reason {
                case .customValidationFailed(let error):
                    let appError = error as? AppError
                    return appError
                default:
                    break
                }
            default:
                break
            }
        }
        return nil
    }

    public func getRequestRetryFailedError(error:Error) -> AppError? {
        if let aferror = error as? AFError {
            switch aferror {
            case .requestRetryFailed(let retryError, _):
                return retryError as? AppError
            default:
                break
            }
        }
        return nil
    }
}
