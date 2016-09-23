//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Varun Rathi on 22/09/16.
//  Copyright © 2016 NovoInvent. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioRecorderDelegate
{
    
    @IBOutlet weak var lblRecord:UILabel!
    @IBOutlet weak var btnStop:UIButton!
    @IBOutlet weak var btnRecord:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func recordAudio()
    {
        
        var audioRecorder:AVAudioRecorder!
        
        let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName="recording.wav"
        let pathArray=[path,recordingName]
        let filePath=NSURL.fileURL(withPathComponents: pathArray)
        let session=AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder=AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled=true
        audioRecorder.delegate=self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recorder.stop()
        finishedRecording(success: flag)
    }
    
    func finishedRecording(success:Bool) {
        if(success)
        {
            
        }
    }
    
    func getDocumentDirectory()->NSURL
    {
      //  let paths=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
       let paths=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory=paths[0] as NSURL
        
        return documentDirectory
        
    }
    
    @IBAction func recordButtonClickd(sender:AnyObject)
    {
        lblRecord.text="Recording..."
        btnStop.isEnabled=true
        btnRecord.isEnabled=false
        
    }
    
    @IBAction func stopButtonClicked(sender:AnyObject)
    {
    
        btnRecord.isEnabled=true
        btnStop.isEnabled=false
        lblRecord.text="Tap to Start recording"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        btnStop.isEnabled=false
        btnRecord.isEnabled=true

        lblRecord.text="Tap to record"
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

