//
//  ProjectsBusiness.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation

class ProjectsBusiness {
    
    private lazy var projectsServices = ProjectServices()
    
    // MARK: -
    
    func projects(parameters: [String: Any],
               completion:@escaping ((_ projectResponse: ProjectResponse?, _ error: Error?) -> ()) ) {
        projectsServices.getProjects(parameters: parameters) { (response, error) in
            completion(response, error)
        }
    }
    
}
