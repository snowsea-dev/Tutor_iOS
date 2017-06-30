//
//  SubjectViewController.swift
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SubjectViewController: BaseViewController {

    @IBOutlet weak var _tableSubject: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedCourse: Course!
    var selectedLevel: Level!

    override func initViews() {
        super.initViews()
        super.setMenuButton()
        selectedView = .Subject
        
        _tableSubject.delegate = self
        _tableSubject.dataSource = self
        
        showLoadingHUD(text: "Please wait...")
        
        selectedCourse = courses[selectedCourseNumber]
        selectedLevel = courses[selectedCourseNumber].levels[selectedLevelNumber]
        
        let apiUrl = "courses/\(selectedCourse.number)/\(selectedLevel.number)/subjects"
        apiConnector.get(api: apiUrl, id: user.email, token: user.token, parameters: nil, delegate: self)
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

extension SubjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as! SubjectTableViewCell
        cell._btnSubject.setTitle(subjects[indexPath.row].name, for: .normal)
        cell.subjectNumber = indexPath.row
        cell._btnSubject.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        cell.setPaid(student.contain(selectedCourse.number, selectedLevel.number, subjects[indexPath.row].number) != nil)
        return cell
    }
    
    func onSelect(_ button: UIButton) {
        performSegue(withIdentifier: "SubjectToChapter", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _tableSubject.reloadData()
    }
    
}

extension SubjectViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data):
            
            let json = JSON(data)
            subjects.removeAll()
            
            for jsonSubject in json.arrayValue {
                let subject = Subject()
                subject.fromJSON(jsonSubject)
                subjects.append(subject)
            }
            
            _tableSubject.reloadData()
            
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
        }
        
    }
}

