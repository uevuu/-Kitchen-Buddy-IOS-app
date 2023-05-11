//
//  MainViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import Swinject

class MainViewModel {
    private let output: MainModuleOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService, output: MainModuleOutput?) {
        self.networkService = networkService
        self.output = output
    }
    
    func showAllWinesThisSort() {
        output?.showAllWinesThisSort()
    }
    
    func showAllSelectionRecipes() {
        output?.showAllSelectionRecipes()
    }
    
    func showRecipeInfo() {
        output?.showRecipeInfo()
    }
    
    func showSettings() {
        output?.showSettings()
    }
}
