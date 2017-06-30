//
//  AssignedSubjectListViewController.swift
//  School
//
//  Created by Admin User on 5/1/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AssignedSubjectListViewController: BaseViewController {

    @IBOutlet var _tableAssignedSubject: UITableView!
    var isReadingLecturer = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initViews() {
        super.initViews()
        
        lecturer.assignedSubjects = []
        
        _tableAssignedSubject.delegate = self
        _tableAssignedSubject.dataSource = self
        apiConnector.get(api: Apis.lecturer, id: user.email, token: user.token, parameters: nil, delegate: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let questionViewController = segue.destination as! QuestionListViewController
        questionViewController.isAnswerable = true
    }

}


extension AssignedSubjectListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignedSubjectCell", for: indexPath) as! AssignedSubjectTableViewCell
        
        let subject = lecturer.assignedSubjects[indexPath.row]
        
        var courseNumber: Int!
        var levelNumber: Int!
        for course in courses {
            if course.number == subject.courseNumber {
                courseNumber = course.number
                break
            }
        }
        
        for level in courses[courseNumber].levels {
            if level.number == subject.levelNumber {
                levelNumber = level.number
                break
            }
        }
        
        cell._lblSubjectName.text = subject.name
        cell._lblCourseName.text = courses[courseNumber].name
        cell._lblLevelName.text = courses[courseNumber].levels[levelNumber].name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lecturer.assignedSubjects.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = lecturer.assignedSubjects[indexPath.row]
        selectedCourseNumber = subject.courseNumber
        selectedLevelNumber = subject.levelNumber
        selectedSubjectNumber = subject.subjectNumber
        
        performSegue(withIdentifier: "AssignedSubjectToQuestionList", sender: nil)
    }
    
}

extension AssignedSubjectListViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data):
            let json = JSON(data)
            if isReadingLecturer {
                lecturer.fromJSON(json)
                
                showLoadingHUD(text: "Please wait...")
                apiConnector.get(api: Apis.courses, id: user.email, token: user.token, parameters: nil, delegate: self)
                isReadingLecturer = false
                
            } else {
                courses.removeAll()
                
                for jsonCourse in json.arrayValue {
                    let course = Course()
                    course.fromJSON(jsonCourse)
                    courses.append(course)
                }
                _tableAssignedSubject.reloadData()
            }
            
        case .failure(let error):
            showMessage(title: "Error", message: error.localizedDescription)
        }
        
    }
}
