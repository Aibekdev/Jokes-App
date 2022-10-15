//
//  NavigationController.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol OnboardingScreenDelegate: AnyObject {
    func loadTypeofJokes()
}

final class OnboardingScreenNavigationController: CustomNavigationController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadOnboardingScreen()
    }
    
    // MARK: - Methods
    private func loadOnboardingScreen() {
        let onboardingScreenVC = OnboardingScreenConfigurator.build(
            with: OnboardingScreenViewController(),
            delegate: self
        )
        self.loadController(with: onboardingScreenVC)
    }
}

// MARK: - WelcomeScreenDelegate
extension OnboardingScreenNavigationController: OnboardingScreenDelegate {
    
    func loadTypeofJokes() {
        let jokeVC = TypeOfJokesConfigurator.build(with: TypeOfJokesViewController())
        self.loadController(with: jokeVC)
    }
    
    }

