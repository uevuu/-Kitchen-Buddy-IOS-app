//
//  MoyaService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 09.04.2023.
//

import Moya

enum MoyaAPIService {
    case getRandomRecipes
    case getWines(sortName: String)
    case getIngredients(letters: String, offset: Int)
    case getRecipeInformation(recipeId: Int)
    case getRecipes(
        query: String?,
        includeIngredients: [String],
        sortBy: SortingParam,
        cusines: [CuisineType],
        diet: DietType,
        minCalories: Int,
        maxCalories: Int,
        minFat: Int,
        maxFat: Int,
        minCarbohydrates: Int,
        maxCarbohydrates: Int,
        minProtein: Int,
        maxProtein: Int,
        time: Int,
        intolerances: [IntoleranceType]
    )
    
    private func complexSearchParameters(
        includeIngredients: [String],
        sortBy: SortingParam,
        cusines: [CuisineType],
        diet: DietType,
        minCalories: Int,
        maxCalories: Int,
        minFat: Int,
        maxFat: Int,
        minCarbohydrates: Int,
        maxCarbohydrates: Int,
        minProtein: Int,
        maxProtein: Int,
        time: Int,
        intolerances: [IntoleranceType]
    ) -> [String: Any] {
        let cusinesString = cusines.map { $0.rawValue } .joined(separator: ",")
        let intolerancesString = intolerances.map { $0.rawValue } .joined(separator: ",")
        let includeIngredientsString = includeIngredients.joined(separator: ",")
        return [
            "includeIngredients": includeIngredientsString,
            "sort": sortBy,
            "cuisine": cusinesString,
            "diet": diet,
            "intolerances": intolerancesString,
            "maxReadyTime": time,
            "minCarbs": minCarbohydrates,
            "maxCarbs": maxCarbohydrates,
            "minProtein": minProtein,
            "maxProtein": maxProtein,
            "minCalories": minCalories,
            "maxCalories": maxCalories,
            "minFat": minFat,
            "maxFat": maxFat
        ]
    }
}

extension MoyaAPIService: TargetType {
    var baseURL: URL {
        URL(string: "https://api.spoonacular.com/")!
    }
    
    var headers: [String: String]? {
        ["x-api-key": "UR_KEY"]
    }
    
    var path: String {
        switch self {
        case .getRandomRecipes:
            return "recipes/random"
        case .getWines:
            return "food/wine/recommendation"
        case .getIngredients:
            return "food/ingredients/search"
        case .getRecipeInformation(let recipeId):
            return "recipes/\(recipeId)/information"
        case .getRecipes:
            return "recipes/complexSearch"
        }
    }
    
    var method: Method {
        .get
    }
    
    var task: Task {
        switch self {
        case .getRecipes(
            let query,
            let includeIngredients,
            let sortBy,
            let cusines,
            let diet,
            let minCalories,
            let maxCalories,
            let minFat,
            let maxFat,
            let minCarbohydrates,
            let maxCarbohydrates,
            let minProtein,
            let maxProtein,
            let time,
            let intolerances
        ):
            let cusinesString = cusines.map { $0.rawValue } .joined(separator: ",")
            let intolerancesString = intolerances.map { $0.rawValue } .joined(separator: ",")
            let includeIngredientsString = includeIngredients.joined(separator: ",")
            return .requestParameters(
                parameters: [
                    "query": query ?? "",
                    "includeIngredients": includeIngredientsString,
                    "sort": sortBy,
                    "cuisine": cusinesString,
                    "diet": diet,
                    "intolerances": intolerancesString,
                    "maxReadyTime": time,
                    "minCarbs": minCarbohydrates,
                    "maxCarbs": maxCarbohydrates,
                    "minProtein": minProtein,
                    "maxProtein": maxProtein,
                    "minCalories": minCalories,
                    "maxCalories": maxCalories,
                    "minFat": minFat,
                    "maxFat": maxFat
                ],
                encoding: URLEncoding.queryString)
        case .getRecipeInformation:
            return .requestPlain
        case .getRandomRecipes:
            return .requestParameters(
                parameters: ["number": 100],
                encoding: URLEncoding.queryString
            )
        case .getWines(let sortName):
            return .requestParameters(
                parameters: ["wine": sortName, "number": 100],
                encoding: URLEncoding.queryString
            )
        case .getIngredients(let letters, let offset):
            return .requestParameters(
                parameters: ["query": letters, "offset": offset],
                encoding: URLEncoding.queryString
            )
        }
    }
}
