//
//  OnboardingScreenRouter.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import Foundation

protocol OnboardingRoutingLogic: AnyObject {
    func navigate()
}

final class OnboardingRouter {
    weak var viewController: DisplayLogic?
    weak var delegate: OnboardingScreenDelegate?
}

extension OnboardingRouter: OnboardingRoutingLogic {
    func navigate() {
        self.delegate?.loadTypeofJokes()    }
}
