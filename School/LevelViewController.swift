//
//  LevelViewController.swift
//  School
//
//  Created by Admin User on 4/20/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit

class LevelViewController: BaseViewController {

    @IBOutlet weak var _tableLevel: UITableView!
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
        selectedView = .Level
        
        _tableLevel.delegate = self
        _tableLevel.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LevelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell
        let level = courses[selectedCourseNumber].levels[indexPath.row]
        cell._btnLevel.setTitle(level.name, for: .normal)
        cell.levelNumber = indexPath.row
        cell._btnLevel.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        return cell
    }
    
    func onSelect(_ button: UIButton) {
        performSegue(withIdentifier: "LevelToSubject", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses[selectedCourseNumber].levels.count
    }
    
}
