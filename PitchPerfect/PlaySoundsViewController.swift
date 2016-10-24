//
//  PlaySoundsVC.swift
//  PitchPerfect
//
//  Created by Varun Rathi on 24/09/16.
//  Copyright © 2016 NovoInvent. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton:UIButton!
    @IBOutlet weak var chipmunkButton:UIButton!
    @IBOutlet weak var vaderButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var rabbitButton:UIButton!

    @IBOutlet weak var stopButton:UIButton! //stopButton
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer:Timer!
    
    enum buttonType : Int {
        case slow = 0,fast,chipMunk,darthVader,echo,reverb
    }
    
    var recordedAudioURL:NSURL!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(playState: .NotPlaying)
    }
    


    @IBAction func btnTileClicked(_ sender: AnyObject) {
        
        print("Sound Played")
        switch (buttonType( rawValue:sender.tag)!) {
        case .slow:
            playSound(rate:0.5)
            
        case .fast:
            playSound(rate:1.5)
            
        case .chipMunk:
            playSound(rate:1000)
            
        case .darthVader:
            playSound(rate:-1000)
            
        case .echo:
            playSound(echo:true)
            
        case .reverb:
            playSound(reverb:true)
            
        }
        
        configureUI(playState: .Playing)
        
    }
    
    @IBAction func btnStopClicked(_ sender: AnyObject) {
        
        print("Stop button pressed")
        stopAudio()
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
