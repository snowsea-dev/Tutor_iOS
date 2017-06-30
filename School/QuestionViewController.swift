//
//  QuestionViewController.swift
//  School
//
//  Created by Admin User on 4/29/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class QuestionViewController: BaseViewController {

    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _txtQuestion: UITextView!
    @IBOutlet weak var _txtAnswer: UITextView!
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
        super.initViews()
        
        _txtQuestion.layer.borderColor = Color.primary.cgColor
        _txtQuestion.layer.borderWidth = Dimen.textBoxBorderWidth
        
        _txtAnswer.layer.borderColor = Color.primary.cgColor
        _txtAnswer.layer.borderWidth = Dimen.textBoxBorderWidth
        
        _txtQuestion.isEditable = false
        _txtAnswer.isEditable = isAnswerable
        
        let question = questions[selectedQuestionNumber]
        
        _lblTitle.text = question.question.title
        _txtQuestion.text = question.question.content
        
        if question.isAnswered == true {
            _txtAnswer.text = question.answer.content
        }
        
        if isAnswerable {
            let submitButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.submit(_:)))
            self.navigationItem.rightBarButtonItem = submitButton
            self.navigationItem.title = "Answer the Question"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func submit(_ sender: Any) {
        if validate() == false {
            return
        }
        
        showLoadingHUD(text: "Submitting...")
        
        let question = questions[selectedQuestionNumber]
        
        let params: Parameters = ["_id": question.id,
                                  "answer": ["content": _txtAnswer.text!]
            
        ]
        
        apiConnector.post(api: Apis.answer, id: user.email, token: user.token, parameters: params, delegate: self)
    }
    
    func validate() -> Bool {
        if _txtAnswer.text == nil || (_txtAnswer.text?.isEmpty)! {
            return false
        }
        return true
    }

}

extension QuestionViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success:
            let question = questions[selectedQuestionNumber]
            question.isAnswered = true
            question.answer.content = _txtAnswer.text!
            showMessage(title: "Answer the question", message: "Successfully Submitted!", handler: {(action) -> Void in
                //self.performSegue(withIdentifier: "SignupToIntro", sender: nil)
            })
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
            
        }
        
    }
}
