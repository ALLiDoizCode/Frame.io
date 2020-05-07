//
//  ProjectsContract.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewProjectsProtocol {
   func onFetchProjectsSuccess(projects:ProjectResponse)
   func onFetchProjectsFailure(error:String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProjectsProtocol {
    
    var view: PresenterToViewProjectsProtocol? { get set }
    var interactor: PresenterToInteractorProjectsProtocol? { get set }
    var router: PresenterToRouterProjectsProtocol? { get set }
    func refresh()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProjectsProtocol {
    
    var presenter: InteractorToPresenterProjectsProtocol? { get set }
    func loadProjects()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProjectsProtocol {
    func fetchProjectsSuccess(projects:ProjectResponse)
    func fetchProjectsFailure(error:String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterProjectsProtocol {
    static func createModule() -> UINavigationController
}
