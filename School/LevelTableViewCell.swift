//
//  LevelTableViewCell.swift
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {

    @IBOutlet weak var _btnLevel: UIButton!
    var levelNumber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        _btnLevel.makeRadiusStyle()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSelect(_ sender: Any) {
        selectedLevelNumber = levelNumber
    }
}
