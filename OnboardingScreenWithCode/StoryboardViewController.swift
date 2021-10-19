//
//  StoryboardViewController.swift
//  OnboardingScreenWithCode
//
//  Created by Юлия Караневская on 18.10.21.
//

import UIKit

class StoryboardViewController: UIViewController {
    
    let orangeImage: UIImageView = {
        let i = UIImageView()
        return i
    }()

    var imageString: String?
    var largeLabelString: String?
    var smallLabelString: String?
    var radius: Int?
    var width: Int?
    var color: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orangeImage.image = UIImage(named: imageString ?? "")
    }

}
