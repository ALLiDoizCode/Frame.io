//
//  ProjectsViewController.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterProjectsProtocol?
    var orderedTeams:[OrderedTeam] = []
    var recent:[RecentProject] = []
    var tableView:UITableView?
    let dateFormatter = DateFormatter()
    var spinner:SpinnerViewController?
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Frame.io"
        tableView = UITableView(frame: self.view.frame)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(ProjectTableViewCell.self, forCellReuseIdentifier: "project")
        self.view.addSubview(tableView ?? UITableView())
        spinner = createSpinnerView()
        presenter?.refresh()
    }
    
    func createSpinnerView() -> SpinnerViewController {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        return child
    }

}

extension ProjectsViewController: PresenterToViewProjectsProtocol{
    
    func onFetchProjectsSuccess(projects:ProjectResponse) {
        var sortedProjects = [Project]()
        if projects.data.count > 5 {
            sortedProjects = projects.data.sorted(by: { projec1, project2 in
                
                let date = Date()
                date.getFormattedDate(format: projec1.attributes.updated_at ?? "")
        
                let date2 = Date()
                date2.getFormattedDate(format: project2.attributes.updated_at ?? "")
            
                return date.timeIntervalSince1970 > date2.timeIntervalSince1970
        
            })
            sortedProjects = Array(sortedProjects.prefix(5))
        }
        
        for project in sortedProjects {
            var name = ""
            for team in projects.included {
                if team.id == project.relationships.team.id {
                   name = team.attributes.name
                }
            }
            let recentProject = RecentProject(team: name, projects: project)
            recent.append(recentProject)
        }
        orderedTeams.append(OrderedTeam(name:""))
        for team in projects.included {
            var relatedProjects:[Project] = []
            for project in projects.data {
                if team.id == project.relationships.team.id {
                    relatedProjects.append(project)
                }
            }
            let orderedTeam = OrderedTeam(name: team.attributes.name, projects: relatedProjects)
            orderedTeams.append(orderedTeam)
        }
        print(recent.count)
        print(orderedTeams.count)
        tableView?.reloadData()
        spinner?.willMove(toParent: nil)
        spinner?.view.removeFromSuperview()
        spinner?.removeFromParent()
    }
    
    @objc func onFetchProjectsFailure(error: String) {
        
    }
}

extension ProjectsViewController :UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderedTeams.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Recent"
        }else {
            return orderedTeams[section].name
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recent.count
        }else {
         return orderedTeams[section].project.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath) as? ProjectTableViewCell
        
        if indexPath.section == 0 {
            cell?.setupCell(project:recent[indexPath.row].project,team:recent[indexPath.row].team)
        }else {
            let projects = orderedTeams[indexPath.section].project
            let project = projects[indexPath.row]
            cell?.setupCell(project:project,team:nil)
        }
        
        return cell ?? ProjectTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
