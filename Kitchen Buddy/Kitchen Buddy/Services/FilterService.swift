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
        sortBy: .none,
        cusines: [],
        diet: .notDiet,
        minCalories: 0,
        maxCalories: 800,
        minFat: 0,
        maxFat: 800,
        minCarbohydrates: 0,
        maxCarbohydrates: 800,
        minProtein: 0,
        maxProtein: 800,
        time: 1440,
        intolerances: []
    )
    
    func getFilters(with query: String) -> RecipesRequestModel {
        filters.query = query
        return filters
    }
}
