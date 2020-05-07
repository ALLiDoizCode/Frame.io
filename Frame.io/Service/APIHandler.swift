import Foundation

// MARK: - Errors
struct NetworkError: Error {
    let message: String
}

struct UnknownParseError: Error { }

// MARK: - APIHandler

protocol RequestHandler {
    
    associatedtype RequestDataType
    
    func makeRequest(from data: RequestDataType) -> Request
}

protocol ResponseHandler {
    
    associatedtype ResponseDataType
    
    func parseResponse(data: Data) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler


// MARK: - Request

protocol RequestBuilder {
    func setHeaders(request: inout URLRequest)
}

class DefaultRequest: RequestBuilder {
    
    func setHeaders(request: inout URLRequest) {
        // header params
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AppHelper.getDeviceID(), forHTTPHeaderField: "DeviceId")
        request.setValue(AppHelper.getCurrentLanguage(), forHTTPHeaderField: "DeviceLanguage")
    }
}

class AuthRequest: DefaultRequest {
    override func setHeaders(request: inout URLRequest) {
        
        super.setHeaders(request: &request)
        // Auth Headers
        request.setValue("token", forHTTPHeaderField: "AuthToken")
        print(request)
    }
}

class Request {
    
    private var request: URLRequest
    
    init(urlRequest: URLRequest, requestBuilder: RequestBuilder) {
        self.request = urlRequest
        // do configuration
        requestBuilder.setHeaders(request: &self.request)
    }
    
    var urlRequest: URLRequest {
        return request
    }
}


// MARK: -
extension RequestHandler {

    /// prepares httpbody
    func set(_ parameters: [String: Any], urlRequest: inout URLRequest) {
        // http body
        if parameters.count != 0 {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }
    }
}



