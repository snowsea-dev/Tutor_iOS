//
//  QuestionViewController.swift
//  School
//
//  Created by Admin User on 4/27/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuestionListViewController: BaseViewController {

    @IBOutlet var _tableQuestion: UITableView!
    var selectedQuestionNumber = 0
    var isAnswerable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initViews() {
        _tableQuestion.delegate = self
        _tableQuestion.dataSource = self
        
        showLoadingHUD(text: "Please wait...")
        let apiUrl = "questions/\(selectedCourseNumber)/\(selectedLevelNumber)/\(selectedSubjectNumber)"
        apiConnector.get(api: apiUrl, id: user.email, token: user.token, parameters: nil, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionViewController = segue.destination as! QuestionViewController
        questionViewController.selectedQuestionNumber = self.selectedQuestionNumber
        questionViewController.isAnswerable = isAnswerable
    }
    
}

extension QuestionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionTableViewCell
        
        let question = questions[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"

        cell._lblTitle.text = question.question.title
        cell._lblEmail.text = question.question.userId
        //cell._lblDate.text = formatter.string(from: question.question.date)
        if question.isAnswered == true {
            cell._lblBadge.isHidden = false
        } else {
            cell._lblBadge.isHidden = true
        }

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuestionNumber = indexPath.row
        performSegue(withIdentifier: "QuestionListToQuestion", sender: nil)
    }
    
}

extension QuestionListViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data):
            
            let json = JSON(data)
            questions.removeAll()
            
            for jsonQuestion in json.arrayValue {
                let question = Question()
                question.fromJSON(jsonQuestion)
                questions.append(question)
            }
            
            _tableQuestion.reloadData()
            
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
        }
        
    }
}

