//
//  ProjectsInteractor.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation

class ProjectsInteractor: PresenterToInteractorProjectsProtocol {
    let projectBusiness = ProjectsBusiness()
    
    // MARK: Properties
    var presenter: InteractorToPresenterProjectsProtocol?
    
    func loadProjects() {
        projectBusiness.projects(parameters: ["include":"team"]) { (response, error) in
            guard let projects = response else {
                self.presenter?.fetchProjectsFailure(error: error?.localizedDescription ?? "")
                return
            }
            
            self.presenter?.fetchProjectsSuccess(projects: projects)
        }
    }
}
