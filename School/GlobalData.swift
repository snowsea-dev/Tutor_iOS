//
//  GlobalData.swift
//  School
//
//  Created by Admin User on 4/25/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func makeRadiusStyle() {
        
        self.layer.borderWidth = Dimen.buttonBorderWidth
        self.layer.borderColor = Color.primary.cgColor
        self.layer.cornerRadius = self.bounds.height / 2
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 2
        self.contentEdgeInsets.left = Dimen.buttonPaddingLeftRight
        self.contentEdgeInsets.right = Dimen.buttonPaddingLeftRight
    }
}

var user = User()
var student = Student()
var lecturer = Lecturer()
var courses = [Course]()
var subjects = [Subject]()
var questions = [Question]()
var selectedCourseNumber = 0
var selectedLevelNumber = 0
var selectedSubjectNumber = 0
var selectedChapterNumber = 0

enum View {
    case Intro, Login, Signup, Welcome, Course, Level, Subject, Chapter, Content, Video, Note
}
var selectedView: View = .Intro


