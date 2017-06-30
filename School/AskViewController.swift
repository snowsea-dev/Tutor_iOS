//
//  AskViewController.swift
//  School
//
//  Created by Admin User on 4/29/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AskViewController: BaseViewController {

    @IBOutlet weak var _txtTitle: UITextField!
    @IBOutlet weak var _txtContent: UITextView!

    
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
                
        _txtTitle.layer.borderColor = Color.primary.cgColor
        _txtTitle.layer.borderWidth = Dimen.textBoxBorderWidth
        _txtContent.layer.borderColor = Color.primary.cgColor
        _txtContent.layer.borderWidth = Dimen.textBoxBorderWidth
        
        let newBackButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.submit(_:)))
        self.navigationItem.rightBarButtonItem = newBackButton
        self.navigationItem.title = "Ask a Question"
        
    
    }
    
    func validate() -> Bool {
        if _txtTitle.text == nil || _txtContent.text == nil || (_txtTitle.text?.isEmpty)! || (_txtContent.text?.isEmpty)! {
            return false
        }
        return true
    }
    
    func submit(_ sender: Any) {
        if validate() == false {
            return
        }
        
        showLoadingHUD(text: "Submitting...")
        
        let params: Parameters = ["course_number": courses[selectedCourseNumber].number,
                      "level_number": courses[selectedCourseNumber].levels[selectedLevelNumber].number,
                      "subject_number": subjects[selectedSubjectNumber].number,
                      "question": ["title": _txtTitle.text!,
                                   "content": _txtContent.text!]

        ]
        
        apiConnector.post(api: Apis.ask, id: user.email, token: user.token, parameters: params, delegate: self)
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

extension AskViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success:
            showMessage(title: "Ask a question", message: "Successfully Submitted!", handler: {(action) -> Void in
                //self.performSegue(withIdentifier: "SignupToIntro", sender: nil)
            })
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
            
        }
        
    }
}

