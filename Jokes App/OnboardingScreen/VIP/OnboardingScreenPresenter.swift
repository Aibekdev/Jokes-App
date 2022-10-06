//
//  OnboardingScreenPresenter.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol OnboardingPresentorOutput: AnyObject {
    
}

final class OnboardingPresenter {
    weak var viewController: OnboardingPresentorOutput?
    
    init(viewController: OnboardingPresentorOutput) {
        self.viewController = viewController
    }
}

extension OnboardingPresenter: OnboardingInteractorOutput {
}
