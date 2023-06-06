//
//  FavouriteViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 06.06.2023.
//

import Swinject

class FavouriteViewModel: SelectionViewModel {
    private let output: FavouriteModuleOutput?
    private let recipeModuleLocalDataSource: RecipeModuleLocalDataSource
    private let favouriteService: FavouriteService
    private var recipes: [Recipe] = []
    
    private var sections: [Section] = [
        RecipeSection()
    ]
    
    init(
        recipeModuleLocalDataSource: RecipeModuleLocalDataSource,
        favouriteService: FavouriteService,
        output: FavouriteModuleOutput?
    ) {
        self.recipeModuleLocalDataSource = recipeModuleLocalDataSource
        self.favouriteService = favouriteService
        self.output = output
    }
    
    func viewDidLoadEvent(completion: @escaping () -> Void) {
        recipes = favouriteService.getRecipes()
        completion()
    }
        
    func getSectionCount() -> Int {
        return sections.count
    }
    
    func getSections() -> [Section] {
        return sections
    }
    
    func getCountOfItemsInSection(sectionNumber: Int) -> Int {
        return recipes.count
    }
    
    func getRecipe(at row: Int) -> Recipe {
        return recipes[row]
    }
    
    func showRecipeInfo(id: Int) {
        recipeModuleLocalDataSource.saveRecipes(recipes)
        output?.showRecipeInfo(id: id)
    }
}
