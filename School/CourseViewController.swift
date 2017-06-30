//
//  CourseViewController.swift
//  School
//
//  Created by Admin User on 4/19/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CourseViewController: BaseViewController {
    
    @IBOutlet var _tableCourse: UITableView!
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
        super.setMenuButton()
        selectedView = .Course
        
        _tableCourse.delegate = self
        _tableCourse.dataSource = self
        
        showLoadingHUD(text: "Please wait...")
        apiConnector.get(api: Apis.courses, id: user.email, token: user.token, parameters: nil, delegate: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseTableViewCell
        let course = courses[indexPath.row]
        
        cell._btnCourse.setTitle(course.name, for: .normal)
        cell.courseNumber = indexPath.row
        cell._btnCourse.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        cell.setAvailable(course.isAvailable)
        return cell
    }
    
    func onSelect(_ button: UIButton) {
        if courses[selectedCourseNumber].isAvailable {
            performSegue(withIdentifier: "CourseToLevel", sender: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
}

extension CourseViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data):
            
            let json = JSON(data)
            courses.removeAll()
            
            for jsonCourse in json.arrayValue {
                let course = Course()
                course.fromJSON(jsonCourse)
                courses.append(course)
            }
            
            _tableCourse.reloadData()
            
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
        }
        
    }
}

