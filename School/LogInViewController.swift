//
//  LogInViewController.swift
//  School
//
//  Created by Colin Taylor on 3/31/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class LogInViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var _txtEmail: PRGValidationField!
    @IBOutlet weak var _txtPassword: PRGValidationField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    override func initViews() {
        super.initViews()
        selectedView = .Login
        
        self.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    private func validateInput() -> Bool {
        
        _txtEmail.isValid = _txtEmail.validationMode.validate(_txtEmail.text!, passToConfirm: nil)
        if _txtEmail.isValid == false {
            return false;
        }
        
        _txtPassword.isValid = _txtPassword.validationMode.validate(_txtPassword.text!, passToConfirm: nil)
        if _txtPassword.isValid == false {
            return false;
        }

        return true;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLogin(_ sender: Any) {
        
        if (validateInput() == false) {
            showMessage(title: "Validation Error...", message: "Please enter correct information.")
            return
        }
        
        showLoadingHUD(text: "Authenticating...")
        
        let params = ["email": _txtEmail.text!,
                      "password": _txtPassword.text!]
        
        apiConnector.setCredentials(email: _txtEmail.text!, password: _txtPassword.text!)
        apiConnector.postWithCredential(api: Apis.login, parameters: params, delegate: self)

    }
    
}


extension LogInViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data as [String: Any]):
            user.fromJSON(data)
            if (user.userType == 1) {
                performSegue(withIdentifier: "LoginToAssignedSubjectList", sender: nil)
            } else {
                performSegue(withIdentifier: "LoginToWelcome", sender: nil)
            }
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
            
        default:
            break
        }
        
    }
}
