//
//  HomeViewController.swift
//  VisionApp
//
//  Created by Samantha Au on 12/27/20.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var objectButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeAppearance()
    }
    
    func changeAppearance() {
        objectButton.layer.cornerRadius = 10
        textButton.layer.cornerRadius = 10
        settingsButton.layer.cornerRadius = 10
        
        let appearance = UserDefaults.standard.string(forKey: "appearance")!
        if(appearance == "warm") {
            imageView.image = UIImage(named: "warmGradient")
            objectButton.setTitleColor(UIColor(displayP3Red: 1.0, green: 0.566, blue: 0.301, alpha: 1.0), for: UIControl.State.normal)
            textButton.setTitleColor(UIColor(displayP3Red: 1.0, green: 0.484, blue: 0.484, alpha: 1.0), for: UIControl.State.normal)
            settingsButton.setTitleColor(UIColor(displayP3Red: 1.0, green: 0.398, blue: 0.766, alpha: 1.0), for: UIControl.State.normal)
        }
        else {
            imageView.image = UIImage(named: "coolGradient")
            objectButton.setTitleColor(UIColor(displayP3Red: 0.219, green: 0.711, blue: 1, alpha: 1.0), for: UIControl.State.normal)
            textButton.setTitleColor(UIColor(displayP3Red: 0.545, green: 0.549, blue: 1, alpha: 1.0), for: UIControl.State.normal)
            settingsButton.setTitleColor(UIColor(displayP3Red: 0.796, green: 0.424, blue: 0.902, alpha: 1.0), for: UIControl.State.normal)
        }
    }
}




