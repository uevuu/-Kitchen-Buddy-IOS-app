//
//  RecipeModuleLocalDataSource.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

class RecipeModuleLocalDataSource {
    private var recipes: [Recipe]?
    
    func saveRecipes(_ recipes: [Recipe]?) {
        if let recipes = recipes {
            self.recipes = recipes            
        }
    }
    
    func getRecipes() -> [Recipe]? {
        return recipes
    }
    
    func getRecipe(id: Int) -> Recipe? {
        return recipes?.first { $0.id == id }
    }
}
