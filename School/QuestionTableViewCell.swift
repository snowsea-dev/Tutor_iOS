//
//  QuestionTableViewCell.swift
//  School
//
//  Created by Admin User on 4/27/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _lblEmail: UILabel!
    @IBOutlet weak var _lblDate: UILabel!
    @IBOutlet weak var _lblBadge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
