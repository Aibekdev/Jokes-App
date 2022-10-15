//
//  TypeOfJokesConfigurator.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import Foundation

final class TypeOfJokesConfigurator: BaseConfigurator {
    @discardableResult
    static func build(with viewController: TypeOfJokesViewController) -> TypeOfJokesViewController {
        let viewController = TypeOfJokesViewController()
        let interactor = TypeOfJokesInteractor()
        let presenter = TypeOfJokesPresenter(viewController: viewController)
        let router = TypeOfJokesRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        viewController.router = router
        return viewController
    }
}
