//
//  ProjectTableViewCell.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    var projecTitle = UILabel()
    var projecTeam = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(projecTitle)
        self.addSubview(projecTeam)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
        projecTitle.text = nil
        projecTeam.text = nil
    }
    
    override func layoutSubviews() {
        projecTitle.translatesAutoresizingMaskIntoConstraints = false
        projecTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        projecTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        projecTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        projecTeam.translatesAutoresizingMaskIntoConstraints = false
        projecTeam.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        projecTeam.topAnchor.constraint(equalTo: projecTitle.topAnchor, constant: 20).isActive = true
        projecTeam.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buildLevelView(level:String) {
        
        
    }
    
    func setupCell(project:Project?,team:String?) {
        
        projecTitle.text = project?.attributes.name
        projecTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        projecTitle.textColor = .darkGray
        projecTitle.textAlignment = .center
        
        guard let team = team else {
            return
        }
        
        projecTeam.text = team
        projecTeam.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        projecTeam.textColor = .darkGray
        projecTeam.textAlignment = .center
    }

}
