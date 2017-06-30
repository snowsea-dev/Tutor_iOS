//
//  ChapterContentViewController.swift
//  School
//
//  Created by Admin User on 4/26/17.
//  Copyright © 2017 snowsea. All rights reserved.
//

import UIKit
import PDFReader
import Alamofire
import UICircularProgressRing

class ChapterContentViewController: BaseViewController {

    @IBOutlet weak var _btnVideo: UIButton!
    @IBOutlet weak var _btnNote: UIButton!
    @IBOutlet weak var _btnNoteDownload: UIButton!
    @IBOutlet weak var _btnVideoDownload: UIButton!
    @IBOutlet weak var _videoDownloadProgress: UICircularProgressRingView!
    @IBOutlet weak var _noteDownloadProgress: UICircularProgressRingView!
    
    var localVideoUrl: URL!
    var localNoteUrl: URL!
    var remoteVideoUrl: URL!
    var remoteNoteUrl: URL!
    var isVideoDownloaded = false
    var isNoteDownloaded = false
    var chapterName = ""
    
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
        selectedView = .Content
        
        _btnVideo.makeRadiusStyle()
        _btnNote.makeRadiusStyle()
        _btnVideoDownload.makeRadiusStyle()
        _btnNoteDownload.makeRadiusStyle()
        
        let chapter = subjects[selectedSubjectNumber].chapters[selectedChapterNumber]
        chapterName = chapter.name
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        remoteVideoUrl = URL(string: chapter.videoUrl)
        remoteNoteUrl = URL(string: chapter.noteUrl)
        
        let fileManager = FileManager.default
        if (remoteVideoUrl != nil) {
            
            localVideoUrl = documentsUrl.appendingPathComponent(remoteVideoUrl.lastPathComponent)
            isVideoDownloaded = fileManager.fileExists(atPath: localVideoUrl.path)
            if isVideoDownloaded {
                _btnVideoDownload.setImage(UIImage(named: "check"), for: .normal)
            }
            else {
                _btnVideoDownload.setImage(UIImage(named: "download"), for: .normal)
            }
        }
        
        if (remoteNoteUrl != nil) {
            
            localNoteUrl = documentsUrl.appendingPathComponent(remoteNoteUrl.lastPathComponent)
            isNoteDownloaded = fileManager.fileExists(atPath: localNoteUrl.path)
            if isNoteDownloaded {
                _btnNoteDownload.setImage(UIImage(named: "check"), for: .normal)
            }
            else {
                _btnNoteDownload.setImage(UIImage(named: "download"), for: .normal)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let videoPlayerViewController = segue.destination as! VideoPlayerViewController
        if isVideoDownloaded {
            videoPlayerViewController.videoUrl = localVideoUrl
        }
        else {
            videoPlayerViewController.videoUrl = remoteNoteUrl
        }
    }
 

    @IBAction func onNote(_ sender: Any) {
        
        if isNoteDownloaded {
            let document = PDFDocument(url: localNoteUrl)!
            let readerController = PDFViewController.createNew(with: document, title: chapterName)
            navigationController?.pushViewController(readerController, animated: true)
        }
        else {
            if remoteNoteUrl != nil {
                download(localUrl: localNoteUrl, remoteUrl: remoteNoteUrl, progress: _noteDownloadProgress, btnDownload: _btnNoteDownload, onFinish: { () in
                    self.isNoteDownloaded = true
                    let document = PDFDocument(url: self.localNoteUrl)!
                    let readerController = PDFViewController.createNew(with: document, title: self.chapterName)
                    self.navigationController?.pushViewController(readerController, animated: true)
                })
            } else {
                showMessage(title: "Accounting Tutors", message: "This subject doesn't contain Video !")
            }
        }
        
    }
    
    func download(localUrl: URL, remoteUrl: URL, progress: UICircularProgressRingView, btnDownload: UIButton, onFinish: (()->Void)?) {
            
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (localUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        progress.isHidden = false
        btnDownload.setImage(nil, for: .normal)
        progress.maxValue = 100
        let utilityQueue = DispatchQueue.global(qos: .utility)
    
        Alamofire.download(remoteUrl.absoluteString, to: destination)
            .downloadProgress(queue: utilityQueue) { prog in
                progress.setProgress(value: CGFloat(prog.fractionCompleted * 100), animationDuration: 0)
            }
            .response { response in
                
                progress.isHidden = true
                if response.error == nil, let _ = response.destinationURL?.path {
                    btnDownload.setImage(UIImage(named: "check"), for: .normal)
                    if let finish = onFinish {
                        finish()
                    }
                }
                else {
                    self.showMessage(title: "Error...", message: "Cannot Download!")
                    btnDownload.setImage(UIImage(named: "download"), for: .normal)
                }
        }
    }
    
    @IBAction func onVideoDownload(_ sender: Any) {
        download(localUrl: localVideoUrl, remoteUrl: remoteVideoUrl, progress: _videoDownloadProgress, btnDownload: _btnVideoDownload, onFinish: nil)
    }

    @IBAction func onNoteDownload(_ sender: Any) {
        if remoteNoteUrl != nil {
            download(localUrl: localNoteUrl, remoteUrl: remoteNoteUrl, progress: _noteDownloadProgress, btnDownload: _btnNoteDownload, onFinish: nil)
        } else {
            showMessage(title: "Accounting Tutors", message: "This subject doesn't contain Note !")
        }
    }
}
