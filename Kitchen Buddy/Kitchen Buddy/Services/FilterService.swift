//
//  FilterService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import Foundation

// MARK: - FilterService
final class FilterService {
    var filters = RecipesRequestModel(
        includeIngredients: [],
        sortBy: "None",
        cusines: Bundle.main.decodeToSelectableSettingModel(file: "CusineTypes.json"),
        diet: Bundle.main.decodeToSelectableSettingModel(file: "DietTypes.json"),
        minCalories: 0,
        maxCalories: 800,
        minFat: 0,
        maxFat: 800,
        minCarbohydrates: 0,
        maxCarbohydrates: 800,
        minProtein: 0,
        maxProtein: 800,
        time: 1440,
        intolerances: Bundle.main.decodeToSelectableSettingModel(file: "IntoleranceTypes.json"),
        meals: Bundle.main.decodeToSelectableSettingModel(file: "MealTypes.json")
    )
    
    func getFilters(with query: String) -> RecipesRequestModel {
        filters.query = query
        return filters
    }
    
    func getIncludeIngredientsCount() -> Int {
        return filters.includeIngredients.count
    }
    
    func getIncludeIngredients() -> [Ingredient] {
        return filters.includeIngredients
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        if !(filters.includeIngredients.contains { $0.id == ingredient.id }) {
            filters.includeIngredients.append(ingredient)
        }
    }
    
    func getIncludeIngredient(at row: Int) -> Ingredient {
        return filters.includeIngredients[row]
    }
    
    func removeIngedient(at row: Int) {
        filters.includeIngredients.remove(at: row)
    }
}
