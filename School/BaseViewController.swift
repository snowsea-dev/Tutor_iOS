//
//  BaseViewController.swift
//  School
//
//  Created by Admin User on 4/22/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift

class BaseViewController: UIViewController {
    
    let progressHUD = ACProgressHUD.shared
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViews() {
        
        progressHUD.hudBackgroundColor = Color.primary
        progressHUD.progressTextColor = Color.white
        progressHUD.indicatorColor = Color.white
    }
    
    func setMenuButton() {
        let newBackButton = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.showMenu(_:)))
        self.navigationItem.rightBarButtonItem = newBackButton
    }
    
    func showMenu(_ sender: Any) {
        let sideMenuViewController = sideMenuVC.menuViewController as! SideMenuViewController
        sideMenuViewController.prepareShow()
        sideMenuViewController.viewController = self
        sideMenuVC.toggleMenu()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showLoadingHUD(text: String) {
        progressHUD.progressText = text
        progressHUD.showHUD()
    }
    
    func hideLoaingHUD() {
        progressHUD.hideHUD()
    }
    
    func showMessage(title: String, message: String, isCancelable: Bool = false, handler: ((_ :UIAlertAction)->Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        if isCancelable {
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        }
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = Color.primary
        alert.view.tintColor = Color.white
        
        let attributedTitle = NSAttributedString(string: title, attributes: [
            NSForegroundColorAttributeName : Color.white
            ])
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSForegroundColorAttributeName : Color.white
            ])
        
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        alert.setValue(attributedMessage, forKey: "attributedMessage")

        
        self.present(alert, animated: true, completion: nil)
    }
    

}
