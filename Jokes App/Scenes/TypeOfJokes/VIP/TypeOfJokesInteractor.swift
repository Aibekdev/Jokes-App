//
//  TypeOfJokesInteractor.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import UIKit

protocol TypeOfJokesInteractorInput {
}

protocol TypeOfJokesInteractorOutput {
}

final class TypeOfJokesInteractor {
    var presenter: TypeOfJokesInteractorOutput!
    
    let cells: [TypeOfJokesModel] = [TypeOfJokesModel(imageName: "", title: "Label")]
                                                
}

extension TypeOfJokesInteractor: TypeOfJokesInteractorInput {
}
