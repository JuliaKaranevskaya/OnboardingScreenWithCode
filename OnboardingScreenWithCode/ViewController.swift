//
//  ViewController.swift
//  OnboardingScreenWithCode
//
//  Created by Юлия Караневская on 15.10.21.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pageVC = StoryboardPageViewController()
    
    let containerView: UIView = {
        let containerV = UIView()
        return containerV
    }()
    
    let roundedView: UIView = {
        let roundedV = UIView()
        roundedV.backgroundColor = UIColor(named: "roundedViewColor")
        roundedV.layer.cornerRadius = 18
        roundedV.layer.masksToBounds = true
        return roundedV
    }()
    
    private let stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.alignment = .center
        stackV.distribution = .equalSpacing
        stackV.spacing = 4
        return stackV
    }()
    
    let largeLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "labelBlackColor")
        l.text = LargeLabelString.firstVC.rawValue
        l.font = l.font.withSize(25)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let smallLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "labelBlackColor")
        l.text = SmallLabelString.firstVC.rawValue
        l.font = l.font.withSize(15)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    private let emptyView: UIView = {
        let emptyV = UIView()
        return emptyV
    }()

    private let pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.numberOfPages = 3
        pageC.currentPage = 0
        pageC.pageIndicatorTintColor = UIColor.systemGray
        pageC.currentPageIndicatorTintColor = UIColor.systemOrange
        return pageC
    }()
    
    
    private let orangeButton: UIButton = {
        let b = UIButton(type: .system)
        b.layer.cornerRadius = 12
        b.clipsToBounds = true
        b.backgroundColor = UIColor(named: "customOrange")
        b.setTitle("Далее", for: .normal)
        b.setTitleColor(UIColor(named: "roundedViewColor"), for: .normal)
        b.addTarget(self, action: #selector(orangeButtonPressed), for: .touchUpInside)
        return b
    }()
    
    private let secondOrangeButton: UIButton = {
        let b = UIButton(type: .system)
        b.layer.cornerRadius = 12
        b.clipsToBounds = true
        b.isHidden = true
        b.backgroundColor = UIColor(named: "customOrange")
        b.setTitleColor(UIColor(named: "roundedViewColor"), for: .normal)
        b.addTarget(self, action: #selector(presentSplashVC), for: .touchUpInside)
        return b
    }()
    
    private let whiteButton: UIButton = {
        let b = UIButton(type: .system)
        b.layer.borderWidth = 2
        b.layer.cornerRadius = 12
        b.layer.borderColor = UIColor(named: "customOrange")?.cgColor
        b.setTitle("Пропустить", for: .normal)
        b.setTitleColor(UIColor(named: "customOrange"), for: .normal)
        b.addTarget(self, action: #selector(presentSplashVC), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        addPageVC()
        
        //swipe gestures of the white view
        let gestureToNextPage = UISwipeGestureRecognizer(target: self, action: #selector(goToNextPage))
        gestureToNextPage.direction = .left
        let gestureToPreviousPage = UISwipeGestureRecognizer(target: self, action: #selector(goToPreviousPage))
        gestureToPreviousPage.direction = .right
        roundedView.addGestureRecognizer(gestureToNextPage)
        roundedView.addGestureRecognizer(gestureToPreviousPage)
   
    }
    
    private func addPageVC() {
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        setPageVCConstraints()
    }
    
    private func setPageVCConstraints() {
        let vcView = pageVC.view
        vcView?.snp.makeConstraints({ make in
            make.top.equalTo(containerView.snp.top)
            make.bottom.equalTo(containerView.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        })
    }
    
    @objc private func presentSplashVC() {
        let vc = SplashViewController()
        present(vc, animated: true)
    }
    
    @objc private func goToNextPage() {
        pageVC.goToNextPage()
        if let currentPageViewController = pageVC.viewControllers?.first as? StoryboardViewController {
            let index = pageVC.orderedViewControllers.firstIndex(of: currentPageViewController)!
            
            manageRoundedViewContentBy(index: index)
        }
    }
    
    @objc private func goToPreviousPage() {
        pageVC.goToPreviousPage()
        if let currentPageViewController = pageVC.viewControllers?.first as? StoryboardViewController {
            let index = pageVC.orderedViewControllers.firstIndex(of: currentPageViewController)!
            
            manageRoundedViewContentBy(index: index)
        }
    }
    
    @objc private func orangeButtonPressed() {
        pageVC.goToNextPage()
   
        if let currentPageViewController = pageVC.viewControllers?.first as? StoryboardViewController {
            let index = pageVC.orderedViewControllers.firstIndex(of: currentPageViewController)!
          
          manageRoundedViewContentBy(index: index)
        }
    }
    
    private func manageRoundedViewContentBy(index: Int) {
        
        pageControl.currentPage = index
        
        if index == 2 {
            whiteButton.isHidden = true
            orangeButton.isHidden = true
            secondOrangeButton.isHidden = false
            secondOrangeButton.setTitle("Начать пользоваться", for: .normal)
            largeLabel.text = LargeLabelString.thirdVC.rawValue
            smallLabel.text = SmallLabelString.thirdVC.rawValue
        } else if index == 1{
            whiteButton.isHidden = false
            secondOrangeButton.isHidden = true
            orangeButton.isHidden = false
            largeLabel.text = LargeLabelString.secondVC.rawValue
            smallLabel.text = SmallLabelString.secondVC.rawValue
        } else if index == 0 {
            whiteButton.isHidden = false
            secondOrangeButton.isHidden = true
            orangeButton.isHidden = false
            largeLabel.text = LargeLabelString.firstVC.rawValue
            smallLabel.text = SmallLabelString.firstVC.rawValue
        }
    }
    
    //Logic of changing screens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let desinationViewController = segue.destination as? StoryboardPageViewController {
        desinationViewController.delegate = self
        desinationViewController.dataSource = self
        pageVC = desinationViewController
        
       }
     }
    
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
          if let currentPageViewController = pageViewController.viewControllers?.first as? StoryboardViewController {
            let index = pageVC.orderedViewControllers.firstIndex(of: currentPageViewController)!
            
            manageRoundedViewContentBy(index: index)
          }
        }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let indexVC = pageVC.orderedViewControllers.firstIndex(of: viewController as! StoryboardViewController), indexVC > 0 else {
            return nil
        }
        let before = indexVC - 1
        
        return pageVC.orderedViewControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexVC = pageVC.orderedViewControllers.firstIndex(of: viewController as! StoryboardViewController), indexVC < (pageVC.orderedViewControllers.count - 1) else {
            return nil
        }
        
        let after = indexVC + 1
        
        return pageVC.orderedViewControllers[after]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func makeConstraints() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.width.equalTo(containerView.snp.height).multipliedBy(375 / 430)
        }
        
        view.addSubview(roundedView)
        
        roundedView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.top.lessThanOrEqualTo(containerView.snp.bottom).inset(32)
        }
        
        roundedView.addSubview(whiteButton)
        
        whiteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin).inset(23)
            make.height.equalTo(40)
            make.leading.equalTo(view).inset(16)
            make.trailing.equalTo(view).inset(16)
        }
        
        roundedView.addSubview(secondOrangeButton)

        secondOrangeButton.snp.makeConstraints { make in
            make.leading.equalTo(view).inset(16)
            make.trailing.equalTo(view).inset(16)
            make.height.equalTo(40)
            make.bottom.equalTo(whiteButton.snp.bottom).inset(23)
        }
        
        roundedView.addSubview(orangeButton)
        
        orangeButton.snp.makeConstraints { make in
            make.leading.equalTo(view).inset(16)
            make.trailing.equalTo(view).inset(16)
            make.height.equalTo(40)
            make.bottom.equalTo(whiteButton.snp.top).inset(-16)
        }
        
        roundedView.addSubview(pageControl)

        pageControl.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.bottom.equalTo(orangeButton.snp.top).inset(4)
            make.centerX.equalTo(orangeButton.snp.centerX)
        }
        
        roundedView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        stackView.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(roundedView.snp.leading)
            make.trailing.equalTo(roundedView.snp.trailing)
            make.bottom.equalTo(pageControl.snp.top).inset(-16)
            make.top.equalTo(roundedView.snp.top).inset(16)
        }
        
        stackView.addArrangedSubview(largeLabel)
        largeLabel.translatesAutoresizingMaskIntoConstraints = false
        largeLabel.setContentHuggingPriority(UILayoutPriority(253), for: .vertical)
        largeLabel.setContentCompressionResistancePriority(UILayoutPriority(753), for: .vertical)
        
        largeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(stackView.snp.trailing).inset(16)
            make.leading.equalTo(stackView.snp.leading).inset(16)
        }
        
        stackView.addArrangedSubview(smallLabel)
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        smallLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        smallLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        
        smallLabel.snp.makeConstraints { make in
            make.trailing.equalTo(stackView.snp.trailing).inset(16)
            make.leading.equalTo(stackView.snp.leading).inset(16)
        }
        
        stackView.addArrangedSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        emptyView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        
        emptyView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(16)
            make.top.equalTo(smallLabel.snp.bottom).inset(-6)
        }
    }
}

