//
//  MoyaService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 09.04.2023.
//

import Moya

enum RecipesAPITarget {
    case getRandomRecipes
    case getWines(sortName: String)
    case getIngredients(letters: String, offset: Int)
    case getRecipeInformation(recipeId: Int)
    case getRecipes(recipesRequestModel: RecipesRequestModel)
}

extension RecipesAPITarget: TargetType {
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
        case .getRecipes( let recipesRequestModel):
            let cusinesString = recipesRequestModel.cusines.map { $0.rawValue } .joined(separator: ",")
            let intolerancesString = recipesRequestModel.intolerances.map { $0.rawValue } .joined(separator: ",")
            let includeIngredientsString = recipesRequestModel.includeIngredients.joined(separator: ",")
            return .requestParameters(
                parameters: [
                    "query": recipesRequestModel.query ?? "",
                    "includeIngredients": includeIngredientsString,
                    "sort": recipesRequestModel.sortBy,
                    "cuisine": cusinesString,
                    "diet": recipesRequestModel.diet,
                    "intolerances": intolerancesString,
                    "maxReadyTime": recipesRequestModel.time,
                    "minCarbs": recipesRequestModel.minCarbohydrates,
                    "maxCarbs": recipesRequestModel.maxCarbohydrates,
                    "minProtein": recipesRequestModel.minProtein,
                    "maxProtein": recipesRequestModel.maxProtein,
                    "minCalories": recipesRequestModel.minCalories,
                    "maxCalories": recipesRequestModel.maxCalories,
                    "minFat": recipesRequestModel.minFat,
                    "maxFat": recipesRequestModel.maxFat
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
