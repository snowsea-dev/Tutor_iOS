//
//  PaddingLabel.swift
//  School
//
//  Created by Admin User on 4/26/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + 20
        return CGSize(width: width, height: superContentSize.height)
    }
}
