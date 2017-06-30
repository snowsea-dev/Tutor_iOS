
//
//  VideoPlayerViewController.swift
//  School
//
//  Created by Admin User on 4/26/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import BMPlayer

class VideoPlayerViewController: BaseViewController {
    
    @IBOutlet weak var playerView: UIView!
    var videoUrl: URL!
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
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue | UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        super.setMenuButton()
        selectedView = .Video
        
        let chapter = subjects[selectedSubjectNumber].chapters[selectedChapterNumber]
        let title = chapter.name
        
        let remoteVideoUrl = URL(string: chapter.videoUrl)
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileManager = FileManager.default
        var url = remoteVideoUrl
        if (remoteVideoUrl != nil) {
            
            let localVideoUrl = documentsUrl.appendingPathComponent((remoteVideoUrl?.lastPathComponent)!)
            let isVideoDownloaded = fileManager.fileExists(atPath: (localVideoUrl.path))
            if isVideoDownloaded {
                url = localVideoUrl
            }
        }
        
        let player = BMPlayer()
        playerView.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(playerView.snp.top)
            make.left.equalTo(playerView.snp.left)
            make.right.equalTo(playerView.snp.right)
            make.bottom.equalTo(playerView.snp.bottom)
        }
        player.delegate = self
        player.backBlock = { [unowned self] (isFullScreen) in
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let asset = BMPlayerResource(url: url!, name: title)
        player.setVideo(resource: asset)
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
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableLandscape = true
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableLandscape = false
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension VideoPlayerViewController: BMPlayerDelegate {
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}
