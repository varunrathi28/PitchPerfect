//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Varun Rathi on 22/09/16.
//  Copyright © 2016 NovoInvent. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController,AVAudioRecorderDelegate
{
    
    @IBOutlet weak var lblRecord:UILabel!
    @IBOutlet weak var btnStop:UIButton!
    @IBOutlet weak var btnRecord:UIButton!
    
    var audioRecorder:AVAudioRecorder!

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
            
            self.performSegue(withIdentifier: "PushOptions", sender: audioRecorder.url)
        }
        
        else
        {
            print("Recoring Failed! Please Try Again.")
        }
    }
   
    
    
    // a utility function for gettting document directory path
    func getDocumentDirectory()->NSURL
    {
   // let paths=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let paths=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
    let documentDirectory=paths[0] as NSURL
        
    return documentDirectory
        
    }
    
    @IBAction func recordButtonClickd(sender:AnyObject)
    {
        lblRecord.text="Recording..."
        btnStop.isEnabled=true
        btnRecord.isEnabled=false
        
        recordAudio()
        
    }
    
    @IBAction func stopButtonClicked(sender:AnyObject)
    {
    
        btnRecord.isEnabled=true
        btnStop.isEnabled=false
        lblRecord.text="Tap to Start recording"
        
        audioRecorder.stop()
        let audioSession=AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        btnStop.isEnabled=false
        btnRecord.isEnabled=true

        lblRecord.text="Tap to record"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PushOptions")
        {
            
            
            let recordedAudioUrl = sender as! NSURL
            let playSoundsViewController=segue.destination as! PlaySoundsViewController
            playSoundsViewController.recordedAudioURL=recordedAudioUrl
            
            
        }
    }
 

}

