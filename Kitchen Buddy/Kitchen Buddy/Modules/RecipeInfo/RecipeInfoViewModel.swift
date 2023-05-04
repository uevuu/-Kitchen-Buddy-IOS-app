//
//  RecipeInfoViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import Swinject

class RecipeInfoViewModel {
    private let output: RecipeInfoModuleOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService, output: RecipeInfoModuleOutput?) {
        self.networkService = networkService
        self.output = output
    }
}

extension RecipeInfoViewModel: RecipeInfoModuleOutput {
    func showRecipeInfo() {
        output?.showRecipeInfo()
    }
}
