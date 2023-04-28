//
//  MainViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import Swinject

class MainViewModel {
    private let latestOpenRecipes: [Recipe] = []
    private let recipeSelection: [Recipe] = []
    private let networkService: NetworkService
    private let wineSorts: [String] = ["White wine", "Red wine", "Trebbiano"]
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func seeRecipeInfo() {
        print("go to next controller")
        
    }
    
    func seeAllSelection() {
    }
    
    func seeWinesBySort() {
    }
}
