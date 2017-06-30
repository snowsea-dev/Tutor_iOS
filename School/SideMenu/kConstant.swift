//
//  kConstant.swift
//  SideMenuSwiftDemo
//
//  Created by Kiran Patel on 1/2/16.
//  Copyright © 2016  SOTSYS175. All rights reserved.
//

import Foundation
import UIKit
let sideMenuVC = KSideMenuVC()
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class kConstant {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func SetInitialMainViewController(_ aStoryBoardID: String)->(KSideMenuVC){
        let sideMenuObj = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuID")
        let mainVcObj = mainStoryboard.instantiateViewController(withIdentifier: aStoryBoardID)
        let navigationController : UINavigationController = UINavigationController(rootViewController: mainVcObj)
        navigationController.navigationBar.tintColor = Color.white
        navigationController.navigationBar.barTintColor = Color.primary
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.white]
        navigationController.isNavigationBarHidden = true
        sideMenuVC.view.frame = UIScreen.main.bounds
        sideMenuVC.mainViewController(navigationController)
        sideMenuVC.menuViewController(sideMenuObj)
        return sideMenuVC
    }
    func SetMainViewController(_ aStoryBoardID: String)->(KSideMenuVC){
        let mainVcObj = mainStoryboard.instantiateViewController(withIdentifier: aStoryBoardID)
        let navigationController : UINavigationController = UINavigationController(rootViewController: mainVcObj)
        navigationController.isNavigationBarHidden = true
        sideMenuVC.view.frame = UIScreen.main.bounds
        sideMenuVC.mainViewController(navigationController)
        return sideMenuVC
    }
   
    // let sideMenuVC = KSideMenuVC()
    
}
