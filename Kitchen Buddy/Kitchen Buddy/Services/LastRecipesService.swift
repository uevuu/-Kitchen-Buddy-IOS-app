//
//  LastRecipesService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 21.05.2023.
//

import Foundation

// MARK: - LastRecipesService
final class LastRecipesService {
    private let userDefaults = UserDefaults.standard
    private var lastRecipes: [Recipe]
    
    init() {
        guard let data = UserDefaults.standard.value(forKey: "MostRecentlyViewedRecipes") as? Data else {
            lastRecipes = []
            return
        }
        do {
            lastRecipes = try PropertyListDecoder().decode([Recipe].self, from: data)
        } catch {
            lastRecipes = []
        }
    }
    
    func saveRecipe(recipe: Recipe) {
        if let existingIndex = lastRecipes.firstIndex(where: { $0.id == recipe.id }) {
            lastRecipes.remove(at: existingIndex)
        } else if lastRecipes.count == 4 {
            lastRecipes.removeFirst()
        }
        lastRecipes.append(recipe)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(lastRecipes), forKey: "MostRecentlyViewedRecipes")
    }
    
    func getRecipes() -> [Recipe] {
        return lastRecipes
    }
}
