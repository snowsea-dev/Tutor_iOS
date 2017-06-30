//
//  ViewController.swift
//  School
//
//  Created by Colin Taylor on 3/31/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController {
    
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var _bkImageView: UIImageView!
    @IBOutlet weak var _btnLogIn: UIButton!
    @IBOutlet weak var _btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func initViews() {
        super.initViews()
        selectedView = .Intro
        
        createMaskLayer()
        
        _btnSignUp.layer.borderWidth = Dimen.buttonBorderWidth
        _btnSignUp.layer.borderColor = Color.primary.cgColor
    }
    
    func createMaskLayer() {
        
        gradientLayer.frame = self.view.bounds

        let color1 = UIColor(red: 0x0 / 255.0, green: 0x0 / 255.0, blue: 0x0 / 255.0, alpha: 0.35).cgColor
        let color2 = UIColor(red: 0x0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.9).cgColor
       
        gradientLayer.colors = [color1, color1, color2]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        _bkImageView.layer.addSublayer(gradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        createMaskLayer()
    }
}

