//
//  Project.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/7/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation

struct ProjectResponse:Codable {
    let data:[Project]
    let included:[Included]
}

struct Included:Codable {
    let attributes:Attributes
    let type:String
    let id:String
}

struct Project:Codable {
    let attributes:Attributes
    let type:String
    let id:String
    let relationships:Relationship
}

struct Attributes:Codable {
    let updated_at:String?
    let name:String
}

struct Relationship:Codable {
    var team:Team
}

struct Team:Codable {
    let id:String
    let type:String
}

final class OrderedTeam {
    let name:String
    var project:[Project]
    
    init(name:String, projects:[Project] = [Project]()) {
        self.name = name
        self.project = projects
    }
}

final class RecentProject {
    let team:String
    var project:Project
    
    init(team:String, projects:Project) {
        self.team = team
        self.project = projects
    }
}
