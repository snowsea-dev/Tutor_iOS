//
//  Subject.swift
//  School
//
//  Created by Admin User on 4/26/17.	//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Chapter {
    
    var number: Int = 0
    var name: String = ""
    var videoUrl: String = ""
    var noteUrl: String = ""
    
    func fromJSON(_ json: JSON) {
        number = json["number"].intValue
        name = json["name"].stringValue
        videoUrl = json["video_url"].stringValue
        noteUrl = json["note_url"].stringValue
    }
}

class Subject {
    
    var courseNumber: Int = 0
    var levelNumber: Int = 0
    var number: Int = 0
    var name: String = ""
    var price: Float = 0.0
    var chapters: [Chapter] = []
    
    func fromJSON(_ json: JSON) {
        
        courseNumber = json["course_number"].intValue
        levelNumber = json["level_number"].intValue
        number = json["number"].intValue
        name = json["name"].stringValue
        price = json["price"].floatValue
        
        chapters = []

        for jsonChapter in json["chapters"].arrayValue {
            let newChapter = Chapter()
            newChapter.fromJSON(jsonChapter)
            chapters.append(newChapter)
        }
    }
}
