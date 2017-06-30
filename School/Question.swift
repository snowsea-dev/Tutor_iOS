//
//  Question.swift
//  School
//
//  Created by Admin User on 4/28/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ask {
    
    var userId: String!
    var title: String!
    var content: String!
    var date: Date!
    
    func fromJSON(_ json: JSON) {
        userId = json["user_id"].stringValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
        date = formatter.date(from: json["created_at"].stringValue)
        
    }
}

class Answer {
    var userId: String!
    var content: String!
    var date: Date!

    func fromJSON(_ json: JSON) {
        userId = json["user_id"].stringValue
        content = json["content"].stringValue
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
        date = formatter.date(from: json["created_at"].stringValue)
    }
}

class Question {
    
    var id: String!
    var courseNumber: Int!
    var levelNumber: Int!
    var subjectNumber: Int!
    var isAnswered: Bool!
    let question: Ask = Ask()
    let answer: Answer = Answer()
    
    func fromJSON(_ json: JSON) {
        
        id = json["_id"].stringValue
        courseNumber = json["course_number"].intValue
        levelNumber = json["level_number"].intValue
        subjectNumber = json["subject_number"].intValue
        question.fromJSON(json["question"])
        
        isAnswered = json["is_answered"].boolValue
        
        if isAnswered == true {
            answer.fromJSON(json["answer"])
        }
        
    }
}
