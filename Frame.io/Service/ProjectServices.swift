import Foundation

class ProjectServices {
    
    func getProjects(parameters: [String: Any], completion: @escaping (ProjectResponse?, Error?) -> ()) {
        // api
        let api = ProjectsAPI()
        // api loader
        let apiRequestLoader = APILoader(apiRequest: api)
        
        apiRequestLoader.loadAPIRequest(requestData: parameters) { (result, error) in
            completion(result, error)
        }
    }
}


