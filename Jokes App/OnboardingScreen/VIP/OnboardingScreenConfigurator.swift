//
//  OnboardingScreenConfigurator.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import Foundation

final class OnboardingScreenConfigurator: BaseConfigurator {
    static func build(with viewController: OnboardingScreenViewController) -> OnboardingScreenViewController {
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(viewController: viewController)
        let router = OnboardingRouter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        viewController.router = router
        
        return viewController
    }
}
