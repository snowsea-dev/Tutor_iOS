//
//  Purchase.swift
//  School
//
//  Created by Admin User on 5/12/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import SwiftyJSON

class CheckoutID {
    
    var id: String = ""
    
    func fromJSON(_ json: JSON) {
        
        id = json["id"].stringValue
    }
    
}

class CheckoutStatus {
    
    var code: String = ""
    var description: String = ""
    
    func fromJSON(_ json: JSON) {
        
        code = json["code"].stringValue
        description = json["description"].stringValue
    }
    
}
