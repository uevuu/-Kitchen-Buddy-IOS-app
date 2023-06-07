//
//  FilterService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import Foundation

// MARK: - FilterService
final class FilterService {
    private var filters = RecipesRequestModel(
        includeIngredients: [],
        sortBy: "None",
        cusines: Bundle.main.decodeToSelectableSettingModel(file: L10n.StaticData.cusines),
        diet: Bundle.main.decodeToSelectableSettingModel(file: L10n.StaticData.diets),
        minCalories: 0,
        maxCalories: 800,
        minFat: 0,
        maxFat: 800,
        minCarbohydrates: 0,
        maxCarbohydrates: 800,
        minProtein: 0,
        maxProtein: 800,
        time: 1440,
        intolerances: Bundle.main.decodeToSelectableSettingModel(file: L10n.StaticData.intolerances),
        meals: Bundle.main.decodeToSelectableSettingModel(file: L10n.StaticData.meals)
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
    
    func getSelectedDiets() -> [String] {
        return filters.diet.getSelectedNames()
    }
    
    func getSelectedMeals() -> [String] {
        return filters.meals.getSelectedNames()
    }
    
    func getSelectedCusines() -> [String] {
        return filters.cusines.getSelectedNames()
    }
    
    func getSelectedIntolerances() -> [String] {
        return filters.intolerances.getSelectedNames()
    }
    
    func getSortParam() -> String {
        return filters.sortBy
    }
    
    func setSortParam(_ param: String) {
        filters.sortBy = param
    }
    
    func getDietsCount() -> Int {
        return filters.diet.count
    }
    
    func getMealssCount() -> Int {
        return filters.meals.count
    }
    
    func getCusinedCount() -> Int {
        return filters.cusines.count
    }
    
    func getIntolerancesCount() -> Int {
        return filters.intolerances.count
    }
    
    func getDiet(at row: Int) -> SelectableSettingModel {
        return filters.diet[row]
    }
    
    func getMeal(at row: Int) -> SelectableSettingModel {
        return filters.meals[row]
    }
    
    func getCusine(at row: Int) -> SelectableSettingModel {
        return filters.cusines[row]
    }
    
    func getIntolerance(at row: Int) -> SelectableSettingModel {
        return filters.intolerances[row]
    }
    
    func swapDietStatus(at row: Int) {
        filters.diet[row].isSelected.toggle()
    }
    
    func swapMealStatus(at row: Int) {
        filters.meals[row].isSelected.toggle()
    }
    
    func swapCusineStatus(at row: Int) {
        filters.cusines[row].isSelected.toggle()
    }
    
    func swapIntoleranceStatus(at row: Int) {
        filters.intolerances[row].isSelected.toggle()
    }
}
