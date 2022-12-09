//
//  TypeOfJokesPresenter.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol TypeOfJokesPresenterOutput: AnyObject {
    func displayData()
}

final class TypeOfJokesPresenter {
    weak var viewController: TypeOfJokesPresenterOutput?
    init(viewController: TypeOfJokesPresenterOutput) {
        self.viewController = viewController
    }
}
extension TypeOfJokesPresenter:TypeOfJokesInteractorOutput {
}
