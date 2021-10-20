//
//  StoryboardPageViewController.swift
//  OnboardingScreenWithCode
//
//  Created by Юлия Караневская on 15.10.21.
//

import UIKit

class StoryboardPageViewController: UIPageViewController, UIScrollViewDelegate {
    
    let firstVC: StoryboardViewController = {
        let vc = StoryboardViewController()
        vc.imageString = ImageString.firstVC.rawValue
        return vc
    }()
    
    let secondVC: StoryboardViewController = {
        let vc = StoryboardViewController()
        vc.imageString = ImageString.secondVC.rawValue
        return vc
    }()
    
    let thirdVC: StoryboardViewController = {
        let vc = StoryboardViewController()
        vc.imageString = ImageString.thirdVC.rawValue
        return vc
    }()
    
    //array of screens
    var orderedViewControllers = [StoryboardViewController]()
    

    //style of pageVC
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderedViewControllers.append(firstVC)
        orderedViewControllers.append(secondVC)
        orderedViewControllers.append(thirdVC)
 
        //setting the firsr screen
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                animated: true,
                completion: nil)
        }
    }
}

extension StoryboardPageViewController {

    func goToNextPage() {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
       setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
       
    }

    func goToPreviousPage() {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
       setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
    }

}


    
