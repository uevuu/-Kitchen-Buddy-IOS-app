//
//  AllSelectionRecipesViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

import Swinject

class AllSelectionRecipesViewModel {
    private let output: AllSelectionRecipesModuleOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService, output: AllSelectionRecipesModuleOutput?) {
        self.networkService = networkService
        self.output = output
    }
}

extension AllSelectionRecipesViewModel: AllSelectionRecipesModuleOutput {
    func showRecipeInfo() {
        output?.showRecipeInfo()
    }
}
