//
//  OnboardingScreenConfigurator.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import Foundation

final class OnboardingScreenConfigurator: BaseDelegateConfigurator {
    @discardableResult
    static func build(
        with viewController: OnboardingScreenViewController,
        delegate: OnboardingScreenDelegate?
    ) -> OnboardingScreenViewController {
        let presenter = OnboardingScreenPresenter()
        let interactor = OnboardingScreenInteractor()
        let router = OnboardingRouter()
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.delegate = delegate
        
        return viewController
    }
}
