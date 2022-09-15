//
//  SettingsViewController.swift
//  VisionApp
//
//  Created by Samantha Au on 12/27/20.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var pitchImageView: UIImageView!
    @IBOutlet weak var appearanceImageView: UIImageView!
    @IBOutlet weak var phoneImageView: UIImageView!
    
    
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var testAudioButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rate = UserDefaults.standard.float(forKey: "rate")
        let pitch = UserDefaults.standard.float(forKey: "pitch")
        let appearance = UserDefaults.standard.string(forKey: "appearance")!
        
        rateSlider.value = rate
        pitchSlider.value = pitch
        
        switch appearance
        {
            case "warm":
                segmentedControl.selectedSegmentIndex = 0
                break
            case "cool":
                segmentedControl.selectedSegmentIndex = 1
                break
            default:
                print("default")
        }
        
        changeAppearance()
    }
    
    func changeAppearance() {
        testAudioButton.layer.cornerRadius = 10
        
        let appearance = UserDefaults.standard.string(forKey: "appearance")!
        if(appearance == "warm") {
            rateImageView.image = UIImage(named: "pinkRate")
            pitchImageView.image = UIImage(named: "orangePitch")
            appearanceImageView.image = UIImage(named: "yellowAppearance")
            phoneImageView.image = UIImage(named: "warmPhone")
        }
        else {
            rateImageView.image = UIImage(named: "purpleRate")
            pitchImageView.image = UIImage(named: "bluePitch")
            appearanceImageView.image = UIImage(named: "greenAppearance")
            phoneImageView.image = UIImage(named: "coolPhone")
        }
    }
    

    
    @IBAction func changedRateSlider(_ sender: Any) {
        UserDefaults.standard.set(rateSlider.value, forKey: "rate")
    }
    
    @IBAction func changedPitchSlider(_ sender: Any) {
        UserDefaults.standard.set(pitchSlider.value, forKey: "pitch")
    }
    
    @IBAction func clickedTestAudioButton(_ sender: Any) {
        let rate = UserDefaults.standard.float(forKey: "rate")
        let pitch = UserDefaults.standard.float(forKey: "pitch")
        
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "This audio is for testing rate and pitch.")
        utterance.rate = rate
        utterance.pitchMultiplier = pitch
        synthesizer.speak(utterance)
    }
    
    @IBAction func changedAppearanceSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
                UserDefaults.standard.set("warm", forKey: "appearance")
                break
            case 1:
                UserDefaults.standard.set("cool", forKey: "appearance")
                break
            default:
                print("default")
        }
        changeAppearance()
    }
}




