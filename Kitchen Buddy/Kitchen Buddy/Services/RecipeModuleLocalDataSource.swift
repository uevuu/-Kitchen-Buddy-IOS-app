//
//  RecipeModuleLocalDataSource.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

class RecipeModuleLocalDataSource {
    private var recipe: Recipe?
    private var recipes: [Recipe]?
    
    func saveRecipe(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    func getRecipe() -> Recipe? {
        return recipe
    }
    
    func saveRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    func getRecipes() -> [Recipe]? {
        return recipes
    }
}
