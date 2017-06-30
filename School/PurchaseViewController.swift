//
//  PurchaseViewController.swift
//  School
//
//  Created by Admin User on 5/12/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PurchaseViewController: BaseViewController {

    @IBOutlet weak var _btnPurchase: UIButton!
    @IBOutlet weak var _lblPrice: UILabel!
    @IBOutlet weak var _lblSubjectName: UILabel!
    
    var status = "ID"
    var checkoutID: String = ""
    
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
        
        _btnPurchase.layer.borderWidth = Dimen.buttonBorderWidth
        _btnPurchase.layer.borderColor = Color.primary.cgColor
        
        let subject = subjects[selectedSubjectNumber];
        _lblPrice.text = "\(subject.price)"
        _lblSubjectName.text = subject.name
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.purchaseViewController = self

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func purchase(_ sender: Any) {
        showLoadingHUD(text: "Please wait...")
        
        self.status = "ID"
        let apiUrl = "\(Apis.checkoutID)\(subjects[selectedSubjectNumber].price)"

        apiConnector.get(api: apiUrl, id: user.email, token: user.token, parameters: nil, delegate: self)
    }
}

extension PurchaseViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data):
            let json = JSON(data)
            
            switch status {
            case "ID":
                let checkoutID = CheckoutID()
                checkoutID.fromJSON(json)
                self.checkoutID = checkoutID.id
                showPayment()
                
            case "Status":
                let checkoutStatus = CheckoutStatus()
                checkoutStatus.fromJSON(json)
                showStatus(status: checkoutStatus)
            
            case "Success":
                
                self.navigationController?.popViewController(animated: true)
                
            default:
                break
            }
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
            
        }
        
    }
    
    func getStatus() {
        self.status = "Status"
        let apiUrl = "\(Apis.checkoutStatus)\(checkoutID)"
        apiConnector.get(api: apiUrl, id: user.email, token: user.token, parameters: nil, delegate: self)
        print("getStatus \(apiUrl)")
    }
    
    func showStatus(status: CheckoutStatus) {
        print("showStatus \(status.code)")
        if status.code == "000.000.000" || status.code == "000.100.110" {
            self.status = "Success"
            showLoadingHUD(text: "Please wait...")
            
            let newPaid = PaidSubject()
            newPaid.courseNumber = courses[selectedCourseNumber].number
            newPaid.levelNumber = courses[selectedCourseNumber].levels[selectedLevelNumber].number
            newPaid.subjectNumber = subjects[selectedSubjectNumber].number
            student.addPaidSubject(subject: newPaid)
            let params: Parameters = ["course_number": newPaid.courseNumber,
                                      "level_number": newPaid.levelNumber,
                                      "number": newPaid.subjectNumber]

            apiConnector.post(api: Apis.checkoutSuccess, id: user.email, token: user.token, parameters: params, delegate: self)
            
        } else {
            //showMessage(title: "Purchase", message: status.description)
        }
    }
    
    func showPayment() {
        
        let provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        
        let checkoutSettings = OPPCheckoutSettings()
        checkoutSettings.schemeURL = "com.snowsea.School.payments"
        
        // Set available payment brands for your shop
        checkoutSettings.paymentBrands = ["VISA", "MASTER"]
        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
        print("ShowPayment \(checkoutID)")
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            if (error != nil) {
                // Executed in case of failure of the transaction for any reason.
                self.showMessage(title: "Error...", message: (error?.localizedDescription)!)
            } else {
                // Send request to your server to obtain the status of the synchronous transaction.
                self.getStatus()
            }
        }, paymentBrandSelectedHandler: { (paymentBrand, completion) in
            // Executed if the shopper selected payment brand.
            // Send request to your server for obtaining a new checkout id if it is required for selected payment brand.
            completion(self.checkoutID)
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely.
        })
    }
	
}
