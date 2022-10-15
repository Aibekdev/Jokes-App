//
//  OnboardingScreenPresenter.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import Foundation

protocol PresentationLogic {
    func presentInitialData()
}

final class OnboardingScreenPresenter {
    weak var viewController: DisplayLogic?
}

extension OnboardingScreenPresenter: PresentationLogic {
    func presentInitialData() {
        self.viewController?.displayData()
    }
}

