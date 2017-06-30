//
//  ChapterTableViewCell.swift
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var _btnChapter: UIButton!
    var chapterNumber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _btnChapter.makeRadiusStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSelect(_ sender: Any) {
        selectedChapterNumber = chapterNumber
    }
    
    func setState(isPaid: Bool) {
        if isPaid == false {
            _btnChapter.setTitleColor(Color.iron, for: .normal)
        }
        else {
            _btnChapter.setTitleColor(Color.primary, for: .normal)
        }
    }
}
