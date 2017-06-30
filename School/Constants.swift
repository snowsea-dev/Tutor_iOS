//
//  Global.swift
//  School
//
//  Created by Admin User on 4/19/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    static let primary = UIColor(red: 226.0 / 255.0, green: 80.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
    static let iron = UIColor(red: 226.0 / 255.0, green: 80.0 / 255.0, blue: 65.0 / 255.0, alpha: 0.5)
    static let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let green = UIColor(red: 65.0 / 255.0, green: 168.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
    static let selectedCell = UIColor(red: 226.0 / 255.0, green: 80.0 / 255.0, blue: 65.0 / 255.0, alpha: 0.1)
};

struct Dimen {
    static let buttonBorderWidth: CGFloat = 1.5
    static let buttonPaddingLeftRight: CGFloat = 10
    static let textBoxBorderWidth: CGFloat = 1
};

struct Apis {
    static let login = "users/login"
    static let signup = "users/register"
    static let courses = "courses/"
    static let student = "students/"
    static let lecturer = "lecturers/"
    static let ask = "questions/ask"
    static let answer = "questions/answer"
    static let checkoutID = "students/checkout/id/"
    static let checkoutStatus = "students/checkout/status/"
    static let checkoutSuccess = "students/checkout/success"
}

let apiConnector = ApiConnector()
