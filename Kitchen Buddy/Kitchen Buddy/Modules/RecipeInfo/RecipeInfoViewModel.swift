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
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func tapOnRecipe() {
        output?.showRecipeInfo()
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
}
