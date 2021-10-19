//
//  SplashViewController.swift
//  OnboardingScreenWithCode
//
//  Created by Юлия Караневская on 19.10.21.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    let backToMainScreenButton: UIButton = {
        let b = UIButton()
        b.setTitle("Вернуться к главному экрану", for: .normal)
        b.setTitleColor(UIColor(named: "roundedViewColor"), for: .normal)
        b.addTarget(self, action: #selector(backToMainScreen), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customOrange")
        view.addSubview(backToMainScreenButton)
        setconstraintsToButton()
    }
    
    @objc private func backToMainScreen() {
        dismiss(animated: true)
    }
    
    private func setconstraintsToButton() {
        backToMainScreenButton.snp.makeConstraints { make in
            make.leading.equalTo(view).inset(16)
            make.trailing.equalTo(view).inset(16)
            make.bottomMargin.equalTo(view).inset(40)
            make.height.equalTo(40)
        }
    }


}
