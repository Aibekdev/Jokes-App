//
//  OnboardingScreenInteractor.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import UIKit

protocol BusinessLogic {
    func presentInitialData()
}

final class OnboardingScreenInteractor {
    var presenter: PresentationLogic?
    let pages: [PageModel] = [PageModel(
            imageName: "onboarding_screen_image_one",
            label: "Joke App",
            descriptionLabel: "Choose the type of jokes"),
    
            PageModel(imageName: "onboarding_screen_image_two",
                      label: "Have fun",
                      descriptionLabel: "Tell these jokes to your friends."),
    
            PageModel(imageName: "onboarding_screen_image_three",
                      label: "Make your day better",
                      descriptionLabel: "One joke a day keeps a doctor away!")]
}

extension OnboardingScreenInteractor: BusinessLogic {
    func presentInitialData() {
        presenter?.presentInitialData(pages: self.pages)
    }
}
