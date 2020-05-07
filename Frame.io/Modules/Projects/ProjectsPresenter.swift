//
//  ProjectsPresenter.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation

class ProjectsPresenter: ViewToPresenterProjectsProtocol {

    // MARK: Properties
    var view: PresenterToViewProjectsProtocol?
    var interactor: PresenterToInteractorProjectsProtocol?
    var router: PresenterToRouterProjectsProtocol?
    
    func refresh() {
        interactor?.loadProjects()
    }
}

extension ProjectsPresenter: InteractorToPresenterProjectsProtocol {
    func fetchProjectsSuccess(projects:ProjectResponse) {
        
        DispatchQueue.main.async {
            self.view?.onFetchProjectsSuccess(projects:projects)
        }
    }
    
    func fetchProjectsFailure(error:String) {
        
        view?.onFetchProjectsFailure(error: error)
    }
        
}
