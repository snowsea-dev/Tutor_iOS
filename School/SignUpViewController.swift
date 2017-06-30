//
//  SignUpViewController.swift
//  School
//
//  Created by Colin Taylor on 3/31/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import MICountryPicker
import Alamofire
import SwiftyJSON


class SignUpViewController: BaseViewController, MICountryPickerDelegate {

    @IBOutlet weak var _txtFirstName: PRGValidationField!
    @IBOutlet weak var _txtLastName: PRGValidationField!
    @IBOutlet weak var _txtCountry: PRGValidationField!
    @IBOutlet weak var _txtEmail: PRGValidationField!
    @IBOutlet weak var _txtPhoneNumber: PRGValidationField!
    @IBOutlet weak var _txtPassword: PRGValidationField!
    @IBOutlet weak var _txtConfirmPassword: PRGValidationField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initViews() {
        super.initViews()
        selectedView = .Signup
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        _txtPassword.otherPasswordField = _txtConfirmPassword
        _txtCountry.valueField.isUserInteractionEnabled = false

    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController!.popToRootViewController(animated: true)
    }

    @IBAction func onLogIn(_ sender: Any) {
        /*let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
 */
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        _txtCountry.text = name
        self.navigationController!.popViewController(animated: true)
    }
    
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
    }
    
    @IBAction func OnCountry(_ sender: Any) {
        let picker = MICountryPicker()
        picker.delegate = self
        picker.showCallingCodes = true
        self.navigationController?.pushViewController(picker, animated: true)
    }
    
    func validateInput()->Bool {
        
        _txtFirstName.isValid = _txtFirstName.validationMode.validate(_txtFirstName.text!, passToConfirm: nil)
        if _txtFirstName.isValid == false {
            return false;
        }
        
        _txtLastName.isValid = _txtLastName.validationMode.validate(_txtLastName.text!, passToConfirm: nil)
        if _txtLastName.isValid == false {
            return false;
        }
        
        _txtEmail.isValid = _txtEmail.validationMode.validate(_txtEmail.text!, passToConfirm: nil)
        if _txtEmail.isValid == false {
            return false;
        }
        
        _txtEmail.isValid = _txtEmail.validationMode.validate(_txtEmail.text!, passToConfirm: nil)
        if _txtEmail.isValid == false {
            return false;
        }
        
        _txtCountry.isValid = _txtCountry.validationMode.validate(_txtCountry.text!, passToConfirm: nil)
        if _txtCountry.isValid == false {
            return false;
        }
        
        _txtEmail.isValid = _txtEmail.validationMode.validate(_txtEmail.text!, passToConfirm: nil)
        if _txtEmail.isValid == false {
            return false;
        }
        
        _txtEmail.isValid = _txtEmail.validationMode.validate(_txtEmail.text!, passToConfirm: nil)
        if _txtEmail.isValid == false {
            return false;
        }
        
        _txtPassword.isValid = _txtPassword.validationMode.validate(_txtPassword.text!, passToConfirm: nil)
        if _txtPassword.isValid == false {
            return false;
        }
        
        _txtConfirmPassword.isValid = _txtConfirmPassword.validationMode.validate(_txtConfirmPassword.text!, passToConfirm: _txtPassword.text!)
        if _txtConfirmPassword.isValid == false {
            return false;
        }
        
        return true
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        if (validateInput() == false) {
            showMessage(title: "Validation Error...", message: "Please enter correct information.")
            return
        }
        
        showLoadingHUD(text: "Authenticating...")
        
        let params = ["first_name": _txtFirstName.text!,
                      "last_name": _txtLastName.text!,
                      "country": _txtCountry.text!,
                      "phone_number": _txtPhoneNumber.text!,
                      "email": _txtEmail.text!,
                      "password": _txtPassword.text!
        ]

        apiConnector.post(api: Apis.signup, parameters: params, delegate: self)
    }

}

extension SignUpViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success:
            showMessage(title: "Welcome", message: "Successfully Registered!", handler: {(action) -> Void in
                self.performSegue(withIdentifier: "SignupToIntro", sender: nil)
            })
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)

        }
        
    }
}
