//
//  ProjectTableViewCell.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    var projectitle = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(projectitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        projectitle.translatesAutoresizingMaskIntoConstraints = false
        projectitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        projectitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        projectitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.42).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buildLevelView(level:String) {
        
        
    }
    
    func setupCell(project:Project?) {
        
        projectitle.text = project?.attributes.name
        projectitle.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        projectitle.textColor = .darkGray
        projectitle.textAlignment = .center
    }

}
