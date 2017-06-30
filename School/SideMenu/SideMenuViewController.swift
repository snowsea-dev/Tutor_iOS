//
//  SideMenuViewController
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController {
    
    @IBOutlet weak var _btnLogOut: UIButton!
    @IBOutlet weak var _btnQuestionsAndAnswers: UIButton!
    @IBOutlet weak var _btnMakeQuestion: UIButton!
    
    
    var viewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initViews() {

        _btnLogOut.makeRadiusStyle()
        _btnQuestionsAndAnswers.makeRadiusStyle()
        _btnMakeQuestion.makeRadiusStyle()
    }
    
    func prepareShow() {
        switch selectedView {
        case .Welcome, .Course, .Level, .Subject:
            _btnQuestionsAndAnswers.isHidden = true
            _btnMakeQuestion.isHidden = true
        default:
            _btnQuestionsAndAnswers.isHidden = false
            let selectedSubject = subjects[selectedSubjectNumber]
            if student.contain(selectedSubject.courseNumber, selectedSubject.levelNumber, selectedSubject.number) != nil {
                _btnMakeQuestion.isHidden = false
            } else {
                _btnMakeQuestion.isHidden = true
            }
            break
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
    @IBAction func ask(_ sender: Any) {
        let askViewController = kConstantObj.mainStoryboard.instantiateViewController(withIdentifier: "AskViewController") as! AskViewController
        viewController?.navigationController?.pushViewController(askViewController, animated: true)
        sideMenuVC.closeMenu()
    }
    
    @IBAction func logout(_ sender: Any) {
        showMessage(title: "Logout", message: "Do you want to log out really?", isCancelable: true, handler: { _ in
            sideMenuVC.closeMenu()
            self.viewController?.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction func questions(_ sender: Any) {
        let questionViewController = kConstantObj.mainStoryboard.instantiateViewController(withIdentifier: "QuestionListViewController") as! QuestionListViewController
        viewController?.navigationController?.pushViewController(questionViewController, animated: true)
        sideMenuVC.closeMenu()
    }
}
