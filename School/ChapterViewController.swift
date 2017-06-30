//
//  ChapterViewController.swift
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class ChapterViewController: BaseViewController {

    @IBOutlet weak var _tableChapter: UITableView!
    @IBOutlet weak var _lblRemainDate: UILabel!
    
    var courseNumber: Int!
    var levelNumber: Int!
    var subjectNumber: Int!
    var isPaid: Bool = false
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
        super.setMenuButton()
        selectedView = .Chapter
        
        courseNumber = courses[selectedCourseNumber].number
        levelNumber = courses[selectedCourseNumber].levels[selectedLevelNumber].number
        subjectNumber = subjects[selectedSubjectNumber].number
        if let paid = student.contain(courseNumber, levelNumber, subjectNumber) {
            isPaid = true
            _lblRemainDate.text = "Your subscription period is \(paid.remainDate) day(s) left."
        } else {
            _lblRemainDate.text = ""
        }
        
        
        _tableChapter.delegate = self
        _tableChapter.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        isPaid = (student.contain(courseNumber, levelNumber, subjectNumber) != nil)
        _tableChapter.reloadData()
    }

}

extension ChapterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath) as! ChapterTableViewCell
        let chapter = subjects[selectedSubjectNumber].chapters[indexPath.row]
        cell.chapterNumber = indexPath.row
        cell._btnChapter.setTitle(chapter.name, for: .normal)
        cell._btnChapter.removeTarget(nil, action: nil, for: .allEvents)
        cell._btnChapter.addTarget(cell, action: #selector(cell.onSelect), for: .touchUpInside)
        if (indexPath.row >= 2 && isPaid == false) {
            cell.setState(isPaid: false)
            cell._btnChapter.addTarget(self, action: #selector(toPurchase), for: .touchUpInside)
        } else {
            cell.setState(isPaid: true)
            cell._btnChapter.addTarget(self, action: #selector(toChapterType), for: .touchUpInside)
        }
        return cell
    }
    
    func toChapterType(_ button: UIButton) {
        performSegue(withIdentifier: "ChapterToChapterType", sender: nil)
    }
    
    func toPurchase(_ button: UIButton) {
        performSegue(withIdentifier: "ChapterToPurchase", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects[selectedSubjectNumber].chapters.count
    }
    
}
