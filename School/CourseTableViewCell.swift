//
//  CourseTableViewCell.swift
//  School
//
//  Created by Admin User on 4/19/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var _btnCourse: UIButton!
    @IBOutlet weak var _lblBadge: UILabel!
    
    var courseNumber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        _btnCourse.makeRadiusStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAvailable(_ isAvailable: Bool) {
        if isAvailable {
            _lblBadge.text = "Opened"
            _lblBadge.backgroundColor = Color.green
            
        }
        else {
            _lblBadge.text = "Coming soon"
            _lblBadge.backgroundColor = Color.primary
        }
    }

    @IBAction func onSelect(_ sender: Any) {
        selectedCourseNumber = courseNumber
    }
}
