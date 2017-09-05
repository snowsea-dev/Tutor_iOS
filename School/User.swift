//
//  User.swift
//  School
//
//  Created by Admin User on 4/22/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var token: String = ""
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var userType: Int = 0
    
    func fromJSON(_ json: [String: Any]) {
        
        token = json["token"] as! String
        let userInfo = json["user"] as! [String: Any]
        email = userInfo["email"] as! String
        firstName = userInfo["first_name"] as! String
        lastName = userInfo["last_name"] as! String
        if let type = userInfo["user_type"] as! Int? {
            userType = type
        }
        else {
            userType = 0
        }
    }
}

class PaidSubject {
    var courseNumber = 0
    var levelNumber = 0
    var subjectNumber = 0
    var remainDate = 0
    
    func fromJSON(_ json: JSON) {
        courseNumber = json["course_number"].intValue
        levelNumber = json["level_number"].intValue
        subjectNumber = json["subject_number"].intValue
        remainDate = json["remain_date"].intValue
    }
}

class Student {
    var userId: String = ""
    var paidSubjects: [PaidSubject] = []
    
    func fromJSON(_ json: JSON) {
        userId = json["user_id"].stringValue
        
        paidSubjects = []
        for subject in json["paid_subjects"].arrayValue {
            let newPaid = PaidSubject()
            newPaid.fromJSON(subject)
            paidSubjects.append(newPaid)
        }
    }
    
    func contain(_ courseNumber: Int, _ levelNumber: Int, _ subjectNumber: Int) -> PaidSubject? {
        for paid in paidSubjects {
            if courseNumber == paid.courseNumber && levelNumber == paid.levelNumber && subjectNumber == paid.subjectNumber {
                return paid
            }
        }
        return nil
    }
    
    func addPaidSubject(subject: PaidSubject) {
        paidSubjects.append(subject)
    }
}

class AssignedSubject {
    var courseNumber = 0
    var levelNumber = 0
    var subjectNumber = 0
    var name = ""
    
    func fromJSON(_ json: JSON) {
        courseNumber = json["course_number"].intValue
        levelNumber = json["level_number"].intValue
        subjectNumber = json["subject_number"].intValue
        name = json["name"].stringValue
    }
}

class Lecturer {
    var userId: String = ""
    var assignedSubjects: [AssignedSubject] = []
    
    func fromJSON(_ json: JSON) {
        userId = json["user_id"].stringValue
        
        assignedSubjects = []
        for subject in json["subjects"].arrayValue {
            let assigned = AssignedSubject()
            assigned.fromJSON(subject)
            assignedSubjects.append(assigned)
        }
    }
    
    func contain(_ courseNumber: Int, _ levelNumber: Int, _ subjectNumber: Int) -> Bool {
        for subject in assignedSubjects {
            if courseNumber == subject.courseNumber && levelNumber == subject.levelNumber && subjectNumber == subject.subjectNumber {
                return true
            }
        }
        return false
    }

}
