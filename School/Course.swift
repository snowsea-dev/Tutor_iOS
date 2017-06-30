//
//  Course.swift
//  School
//
//  Created by Admin User on 4/26/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import SwiftyJSON

class Level {
    
    var number: Int = 0
    var name: String = ""
    
    func fromJSON(_ json: JSON) {
        number = json["number"].intValue
        name = json["name"].stringValue
    }
}

class Course {

    var number: Int = 0
    var name: String = ""
    var isAvailable: Bool = false
    var levels: [Level] = []
    
    func fromJSON(_ json: JSON) {
        
        number = json["number"].intValue
        name = json["name"].stringValue
        isAvailable = json["is_available"].boolValue
    
        levels = []
        for level in json["levels"].arrayValue {
            let newLevel = Level()
            newLevel.fromJSON(level)
            levels.append(newLevel)
        }
    }
    
}
