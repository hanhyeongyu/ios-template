import Foundation

// MARK: Files upload
public typealias UploadFiles = [String: UploadFile]
public struct UploadFile {
    let data: Data
    let fileName: String
    let mimeType: String

    public init(data: Data, fileName: String, mimeType: String) {
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
