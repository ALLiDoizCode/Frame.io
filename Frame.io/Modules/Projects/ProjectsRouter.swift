//
//  ProjectsRouter.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit

class ProjectsRouter: PresenterToRouterProjectsProtocol {
   
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        let viewController = ProjectsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = UIColor(red:0.41, green:0.21, blue:0.81, alpha:1.00)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        let presenter: ViewToPresenterProjectsProtocol & InteractorToPresenterProjectsProtocol = ProjectsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ProjectsRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProjectsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
}
