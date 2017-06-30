//
//  AssignedSubjectTableViewCell.swift
//  School
//
//  Created by Admin User on 5/1/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class AssignedSubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var _lblCourseName: UILabel!
    @IBOutlet weak var _lblLevelName: PaddingLabel!
    @IBOutlet weak var _lblSubjectName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedBackgroundView?.backgroundColor = Color.iron
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

        
    }

}
