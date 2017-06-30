//
//  MainViewController.swift
//  School
//
//  Created by Colin Taylor on 4/1/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: BaseViewController {
    @IBOutlet weak var _btnCourses: UIButton!
    @IBOutlet weak var _btnContactUs: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initViews() {
        super.initViews()
        super.setMenuButton()
        selectedView = .Welcome
        
        _btnCourses.makeRadiusStyle()
        _btnContactUs.makeRadiusStyle()
        
        self.navigationItem.hidesBackButton = true
        
        showLoadingHUD(text: "Please wait...")
        apiConnector.get(api: Apis.student, id: user.email, token: user.token, parameters: nil, delegate: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func onContactUs(_ sender: Any) {
        //sideMenuVC.toggleMenu()
    }
}

extension MainViewController: ResponseDelegate {
    
    internal func response(_ response: DataResponse<Any>) {
        hideLoaingHUD()
        
        switch response.result {
        case .success(let data):
            let json = JSON(data)
            
            student.fromJSON(json)
            
        case .failure:
            let json = JSON(response.data!)
            showMessage(title: "Error...", message: json["message"].stringValue)
        }
        
    }
}
