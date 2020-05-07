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
    var tableView:UITableView?
    let dateFormatter = DateFormatter()
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let infoButton = UIButton(type: .infoLight)
        infoButton.tintColor = .white
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        self.title = "Smart Investing"
        tableView = UITableView(frame: self.view.frame)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(ProjectTableViewCell.self, forCellReuseIdentifier: "project")
        self.view.addSubview(tableView ?? UITableView())
        presenter?.refresh()
    }
    
    @objc func infoButtonTapped() {
        
    }

}

extension ProjectsViewController: PresenterToViewProjectsProtocol{
    
    func onFetchProjectsSuccess(projects:ProjectResponse) {
        
        let recent = OrderedTeam(name: "Recent")
        
        if projects.data.count > 5 {
            let sortedProjects = projects.data.sorted(by: { projec1, project2 in
                
                let date = Date()
                date.getFormattedDate(format: projec1.attributes.updated_at ?? "")
        
                let date2 = Date()
                date2.getFormattedDate(format: project2.attributes.updated_at ?? "")
            
                return date.timeIntervalSince1970 > date2.timeIntervalSince1970
        
            })
            recent.project = Array(sortedProjects.prefix(5))
        }
        
        
        
        orderedTeams.append(recent)
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
        print(orderedTeams[0].name)
        tableView?.reloadData()
    }
    
    @objc func onFetchProjectsFailure(error: String) {
        
    }
}

extension ProjectsViewController :UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderedTeams.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return orderedTeams[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedTeams[section].project.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let projects = orderedTeams[indexPath.section].project
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath) as? ProjectTableViewCell
        cell?.setupCell(project:projects[indexPath.row])
        return cell ?? ProjectTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
