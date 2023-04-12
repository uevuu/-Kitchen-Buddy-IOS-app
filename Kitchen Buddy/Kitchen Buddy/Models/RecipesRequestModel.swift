//
//  RecipesRequestModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 13.04.2023.
//
struct RecipesRequestModel {
    var query: String?
    var includeIngredients: [String]
    var sortBy: SortingParam
    var cusines: [CuisineType]
    var diet: DietType
    var minCalories: Int
    var maxCalories: Int
    var minFat: Int
    var maxFat: Int
    var minCarbohydrates: Int
    var maxCarbohydrates: Int
    var minProtein: Int
    var maxProtein: Int
    var time: Int
    var intolerances: [IntoleranceType]
}
