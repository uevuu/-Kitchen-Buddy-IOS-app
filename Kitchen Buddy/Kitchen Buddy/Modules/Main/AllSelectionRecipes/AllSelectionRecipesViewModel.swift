//
//  AllSelectionRecipesViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

import Swinject

class AllSelectionRecipesViewModel {
    private let output: AllSelectionRecipesModuleOutput?
    private let recipes: [Recipe]
    
    private var sections: [Section] = [
        RecipeSection()
    ]
    
    init(
        recipeModuleLocalDataSource: RecipeModuleLocalDataSource,
        output: AllSelectionRecipesModuleOutput?
    ) {
        self.output = output
        guard let recipes = recipeModuleLocalDataSource.getRecipes() else {
            fatalError("Error with swithcing to all section recipes module")
        }
        self.recipes = recipes
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
        output?.showRecipeInfo(id: id)
    }
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
}
