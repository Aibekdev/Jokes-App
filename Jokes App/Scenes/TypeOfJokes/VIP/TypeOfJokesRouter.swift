//
//  TypeOfJokesRouter.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import Foundation

protocol TypeOfJokesRoutingLogic: AnyObject {
    func navigate()
}
final class TypeOfJokesRouter {
}
extension TypeOfJokesRouter: TypeOfJokesRoutingLogic {
    func navigate() {
    }
}
