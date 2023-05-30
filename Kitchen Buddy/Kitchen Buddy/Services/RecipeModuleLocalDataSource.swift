//
//  RecipeModuleLocalDataSource.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

class RecipeModuleLocalDataSource {
    private var recipes: [Recipe]?
    
    func saveRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    func getRecipes() -> [Recipe]? {
        return recipes
    }
    
    func getRecipe(id: Int) -> Recipe? {
        return recipes?.first(where: { $0.id == id })
    }
}
