//
//  JudgemnetHallViewController.swift
//  The Button
//
//  Created by Ben Erekson on 8/19/21.
//

import UIKit
import AVKit

class JudgementHallViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var theButton: UIButton!
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        theButton.layer.cornerRadius = 35
        theButton.layer.masksToBounds = true
    }
    //MARK: - Actions
    @IBAction func theButtonWasTapped(_ sender: Any) {
        castJudgement()
    }
    
    //MARK: - The final judgement
    func castJudgement() {
        if let path = Bundle.main.path(forResource: "superSecretEnding", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true) {
                video.play()
            }
        }
    }
    
}
