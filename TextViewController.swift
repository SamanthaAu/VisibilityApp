//
//  TextViewController.swift
//  VisionApp
//
//  Created by Samantha Au on 12/27/20.
//

import UIKit
import AVFoundation
import FirebaseMLVision

class TextViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var recognizeButton: UIButton!
    
    let cameraPicker = UIImagePickerController()
    let photoPicker = UIImagePickerController()
    var textRecognizer: VisionTextRecognizer!
    var image: UIImage!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        textRecognizer = Vision.vision().onDeviceTextRecognizer()
        
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = true
        
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        photoPicker.allowsEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeAppearance()
    }
    
    func changeAppearance() {
        recognizeButton.layer.cornerRadius = 10
        
        let appearance = UserDefaults.standard.string(forKey: "appearance")!
        if(appearance == "warm") {
            cameraButton.setBackgroundImage(UIImage(named: "warmCamera"), for: UIControl.State.normal)
            photoButton.setBackgroundImage(UIImage(named: "warmPhoto"), for: UIControl.State.normal)
            recognizeButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.789, blue: 0.176, alpha: 0.75)
        }
        else {
            cameraButton.setBackgroundImage(UIImage(named: "coolCamera"), for: UIControl.State.normal)
            photoButton.setBackgroundImage(UIImage(named: "coolPhoto"), for: UIControl.State.normal)
            recognizeButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.918, blue: 0.668, alpha: 0.75)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = userPickedImage
            image = userPickedImage
        }
        
        if picker == cameraPicker {
            cameraPicker.dismiss(animated: true, completion: nil)
        }
        else {
            photoPicker.dismiss(animated: true, completion: nil)
        }
    }
  
    func runTextRecognition(with image: UIImage) {
        
        let visionImage = VisionImage (image: image)
        var str = ""
        
        // Text recognition
        textRecognizer.process(visionImage) { result, error in
            let synthesizer = AVSpeechSynthesizer()
            
            guard error == nil, let result = result else {
                let utterance = AVSpeechUtterance(string: "No text detected.")
                synthesizer.speak(utterance)
                return
            }

            str += result.text
            
            let utterance = AVSpeechUtterance(string: str)
            synthesizer.speak(utterance)
        }
    }
    
    @IBAction func clickedCameraButton(_ sender: Any) {
        present(cameraPicker, animated: true)
    }
    
    @IBAction func clickedPhotoButton(_ sender: Any) {
        present(photoPicker, animated: true)
    }
    
    @IBAction func clickedRcognizeTextButton(_ sender: Any) {
        if(image != nil) {
            runTextRecognition(with: image)
        }
        else {
            let utterance = AVSpeechUtterance(string: "No image selected.")
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
    }
}




