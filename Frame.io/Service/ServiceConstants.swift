import Foundation

enum Environment {
    
    case development
    case production
    
    func baseURL() -> String {
        return "\(urlProtocol())://\(subdomain()).\(domain())\(route())"
    }
    
    func urlProtocol() -> String {
        switch self {
        case .production:
            return "https"
        default:
            return "http"
        }
    }
    
    func domain() -> String {
        switch self {
        case .development, .production:
            return "herokuapp.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development:
            print("development")
            return "frameio-swift-exercise"
        case .production:
            print("production")
            return "frameio-swift-exercise"
        }
    }
    
    func route() -> String {
        //return "/api/v1"
        return ""
    }
    
}
extension Environment {
    func host() -> String {
        return "\(self.subdomain()).\(self.domain())"
    }
}


// MARK:- APIs

#if DEBUG
let environment: Environment = Environment.development
#else
let environment: Environment = Environment.production
#endif

let baseUrl = environment.baseURL()

struct Path {
    
    struct Projects {
        
        var fetch: String { return "\(baseUrl)/projects" }
    
    }
}
