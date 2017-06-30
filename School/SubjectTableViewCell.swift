//
//  SubjectTableViewCell.swift
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var _btnSubject: UIButton!
    @IBOutlet weak var _lblBadge: PaddingLabel!
    
    var subjectNumber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        _btnSubject.makeRadiusStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSelect(_ sender: Any) {
        selectedSubjectNumber = subjectNumber
    }
    
    func setPaid(_ isPaid: Bool) {
        _lblBadge.isHidden = isPaid
    }
}
