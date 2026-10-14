import Foundation
import AppUtil
import Alamofire
import CocoaLumberjackSwift

public let API: Api = ApiImp.shared

public class ApiImp: Api {

    public static let shared = ApiImp()

    public var sessions : [SessionType:Session] = [SessionType:Session]()

    private init() {
        initSession()
    }

    public func send<T>(
        _ request: T,
        sessionType: SessionType,
        completion: @escaping (T.Output?, Error?) -> Void
    ) where T : APIRequest {
        session(sessionType)
            .request(
                request.endpoint,
                method: Alamofire.HTTPMethod(request.method),
                parameters: request.query,
                encoding: request.method.encoder(),
                headers: Alamofire.HTTPHeaders(request.header)
            )
            .validate { (_, response, data) -> Alamofire.Request.ValidationResult in
                ApiImp.validate(request, sessionType: sessionType, response: response, data: data)
            }
            .responseData(
                emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
                emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
            ) { [unowned self] response in
                do {
                    let result: T.Output = try responseData(response: response, sessionType: sessionType)
                    completion(result, nil)
                } catch (let error) {
                    completion(nil, error)
                }
            }
    }

    public func send<T>(
        _ request: T,
        sessionType: SessionType
    ) async throws -> T.Output where T : APIRequest {
        let dataRequest = session(sessionType)
            .request(
                request.endpoint,
                method: Alamofire.HTTPMethod(request.method),
                parameters: request.query,
                encoding: request.method.encoder(),
                headers: Alamofire.HTTPHeaders(request.header)
            )
            .validate { (_, response, data) -> Alamofire.Request.ValidationResult in
                ApiImp.validate(request, sessionType: sessionType, response: response, data: data)
            }

        let response = await dataRequest.serializingData(
            emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
            emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
        ).response

        let result: T.Output =  try responseData(response: response, sessionType: sessionType)
        return result
    }
    
    public func send<T>(
        _ request: T,
        sessionType: SessionType
    ) async throws -> T.Output where T : APIJSONRequest {
        let dataRequest = session(sessionType).request(
                request.endpoint,
                method: Alamofire.HTTPMethod(request.method),
                parameters: request.body,
                encoder: .json,
                headers: Alamofire.HTTPHeaders(request.header)
            )
            .validate { (_, response, data) -> Alamofire.Request.ValidationResult in
                ApiImp.validate(request, sessionType: sessionType, response: response, data: data)
            }
            .cURLDescription {
                DDLogDebug("\($0)")
            }
        
        let response = await dataRequest.serializingData(
            emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
            emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
        ).response
        
        let result: T.Output = try responseData(response: response, sessionType: sessionType)
        return result
    }
    
    public func send<T>(_ request: T, sessionType: SessionType) async throws -> T.Output where T : APIDataRequest {
        let urlRequest = try RequestFactory(request: request).urlRequestRepresentation()
        let session = session(sessionType)
        let dataRequest = session.request(urlRequest)
            .validate { (_, response, data) -> Alamofire.Request.ValidationResult in
                ApiImp.validate(request, sessionType: sessionType, response: response, data: data)
            }

        let response = await dataRequest.serializingData(
            emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
            emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
        ).response

        let result: T.Output = try responseData(response: response, sessionType: sessionType)
        return result
    }

    public func upload<T>(
        _ request: T,
        sessionType: SessionType
    ) async throws -> T.Output where T : APIUploadRequest {

        let uploadRequest = session(sessionType)
            .upload(
                multipartFormData: { multipartForData in
                    for (key, file) in request.file {
                        multipartForData.append(
                            file.data,
                            withName: key,
                            fileName: file.fileName,
                            mimeType: file.mimeType
                        )
                    }
                    
                    for (key, value) in request.query {
                        if let data = String(describing: value).data(using: .utf8) {
                            multipartForData.append(data, withName: key)
                        }
                    }
                },
                to: request.endpoint,
                method: Alamofire.HTTPMethod(request.method),
                headers: Alamofire.HTTPHeaders(request.header)
            )
            .validate { (_, response, data) -> Alamofire.Request.ValidationResult in
                ApiImp.validate(request, sessionType: sessionType, response: response, data: data)
            }

        let response = await uploadRequest.serializingData(
            emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
            emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
        ).response

        let result: T.Output = try responseData(response: response, sessionType: sessionType)
        return result
    }

    public func download<T>(
        _ request: T,
        sessionType: SessionType
    ) async throws -> T.Output where T : APIDownloadRequest {        
        let session = session(sessionType)
        let destination = DownloadRequest.suggestedDownloadDestination(
            for: .cachesDirectory,
            in: .userDomainMask,
            options: [.removePreviousFile, .createIntermediateDirectories]
        )
        let downloadRequest = session
            .download(
                request.endpoint,
                method: Alamofire.HTTPMethod(request.method),
                headers: Alamofire.HTTPHeaders(request.header),
                to: destination
            )
            .validate({ [unowned self] (_, response, fileURL) -> Alamofire.Request.ValidationResult in
                validate(request, sessionType: sessionType, response: response, fileURL: fileURL)
            })

        Task {
          for await progress in downloadRequest.downloadProgress() {
              DDLogInfo("Download progress: \(progress.fractionCompleted)")
          }
        }

        return try await downloadRequest.serializingDownloadedFileURL()
            .result
            .get()
    }
}

// MARK: Validation
extension ApiImp {
    private static func validate<T>(
        _ request: T,
        sessionType: SessionType,
        response: HTTPURLResponse,
        data: Data?
    ) -> Request.ValidationResult where T : APIRequest {
        DDLogDebug("===================================================================================================")
        DDLogDebug("session: \n type: \(sessionType)\n\n")

        DDLogInfo("request: \n method: \(request.method)\n url:\(request.endpoint)\n headers:\(String(describing: request.header))\n parameters: \(request.query) \n\n")

        if let data = data {
            var json : Any?
            do {
                json = try JSONSerialization.jsonObject(with:data, options:[])
            } catch {
                DDLogError("JSONSerialization fail: \(error)}")
            }
            DDLogInfo("response:\n \(String(describing: json))\n\n" )

            if let appError = AppError(response: response, data: data) {
                return .failure(appError)
            } else {
                return .success(Void())
            }
        } else {
            if 200 ..< 300 ~= response.statusCode {
                return .success(Void())
            } else {
                return .failure(AppError(reason: .Unknown, message: "data is nil."))
            }
        }
    }
    
    private static func validate<T>(
        _ request: T,
        sessionType: SessionType,
        response: HTTPURLResponse,
        data: Data?
    ) -> Request.ValidationResult where T : APIJSONRequest {
        DDLogDebug("===================================================================================================")
        DDLogDebug("session: \n type: \(sessionType)\n\n")

        DDLogInfo("request: \n method: \(request.method)\n url:\(request.endpoint)\n headers:\(String(describing: request.header))\n parameters: \(request.body) \n\n")

        if let data = data {
            var json : Any?
            do {
                json = try JSONSerialization.jsonObject(with:data, options:[])
            } catch {
                DDLogError("JSONSerialization fail: \(error)}")
            }
            DDLogInfo("response:\n \(String(describing: json))\n\n" )

            if let appError = AppError(response: response, data: data) {
                return .failure(appError)
            } else {
                return .success(Void())
            }
        } else {
            if 200 ..< 300 ~= response.statusCode {
                return .success(Void())
            } else {
                return .failure(AppError(reason: .Unknown, message: "data is nil."))
            }
        }
    }
    
    private static func validate<T>(
        _ request: T,
        sessionType: SessionType,
        response: HTTPURLResponse,
        data: Data?
    ) -> Request.ValidationResult where T : APIDataRequest {
        DDLogDebug("===================================================================================================")
        DDLogDebug("session: \n type: \(sessionType)\n\n")

        DDLogInfo("request: \n method: \(request.method)\n url:\(request.endpoint)\n headers:\(String(describing: request.header))\n parameters: \(request.body) \n\n")

        if let data = data {
            var json : Any?
            do {
                json = try JSONSerialization.jsonObject(with:data, options:[])
            } catch {
                DDLogError("JSONSerialization fail: \(error)}")
            }
            DDLogInfo("response:\n \(String(describing: json))\n\n" )

            if let appError = AppError(response: response, data: data) {
                return .failure(appError)
            } else {
                return .success(Void())
            }
        } else {
            if 200 ..< 300 ~= response.statusCode {
                return .success(Void())
            } else {
                return .failure(AppError(reason: .Unknown, message: "data is nil."))
            }
        }
    }
        
    private func validate<T>(
        _ request: T,
        sessionType: SessionType,
        response: HTTPURLResponse,
        fileURL: URL?
    ) -> Request.ValidationResult where T : APIRequest {
        DDLogDebug("===================================================================================================")
        DDLogDebug("session: \n type: \(sessionType)\n\n")

        DDLogInfo("request: \n method: \(request.method)\n url:\(request.endpoint)\n headers:\(String(describing: request.header))\n parameters: \(request.query)) \n\n")

        if let fileURL = fileURL {
            DDLogInfo("downlaedfile url: \(fileURL)")
            return .success(Void())
        } else {
            if 200 ..< 300 ~= response.statusCode {
                return .success(Void())
            } else {
                return .failure(AppError(reason: .Unknown, message: "download fail"))
            }
        }
    }
}

// MARK: ResponseData
extension ApiImp {
    func responseData<Output>(
        response: AFDataResponse<Data>,
        sessionType: SessionType
    ) throws -> Output where Output: Decodable {
        if let afError = response.error, let retryError = self.getRequestRetryFailedError(error:afError) {
            DDLogError("response:\n api error: \(retryError)")
            throw retryError
        } else if let afError = response.error, self.getError(error:afError) == nil {
            DDLogError("response:\n not api error: \(afError)")
            throw afError
        } else if Output.self == Empty.self, let _ = response.response {
            return Empty() as! Output
        } else if  let data = response.data, let response = response.response {
            if let appError = AppError(response: response, data: data) {
                throw appError
            }
            let output = try AppJSONDecoder.customIso8601Date.decode(Output.self, from: data)
            return output
        } else {
            DDLogError("response:\n error: response  is nil.")
            throw AppError(reason: .Unknown, message: "response is nil.")
        }
    }
}

extension ApiImp {
    static let defaultEmptyResponseCodes :Set<Int> = [200, 204, 205]
    static let defaultEmptyRequestMethods: Set<Alamofire.HTTPMethod> = [.head, .get, .post]
}

// MARK: Session
extension ApiImp {
    private func initSession() {
        let apiSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        apiSessionConfiguration.tlsMinimumSupportedProtocolVersion = .TLSv12
        addSession(type: .Api, session:Session(configuration: apiSessionConfiguration, interceptor: ApiRequestAdapter()))
    }

    public func addSession(type:SessionType, session:Session) {
        if self.sessions[type] == nil {
            self.sessions[type] = session
        }
    }

    public func session(_ sessionType: SessionType) -> Session {
        return sessions[sessionType] ?? sessions[.Api]!
    }
}
