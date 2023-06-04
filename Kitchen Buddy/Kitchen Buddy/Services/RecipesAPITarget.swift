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
    case getSimilarRecipes(recipeId: Int)
    case getRecipeInformationBulk(ids: [Int])
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
        case .getSimilarRecipes(let recipeId):
            return "recipes/\(recipeId)/similar"
        case .getRecipeInformationBulk:
            return "recipes/informationBulk"
        }
    }
    
    var method: Method {
        .get
    }
    
    var task: Task {
        switch self {
        case .getRecipes( let recipesRequestModel):
            let cusinesString = recipesRequestModel.cusines.getSelected().joined(separator: ",")
            let intolerancesString = recipesRequestModel.intolerances.getSelected().joined(separator: ",")
            let includeIngredientsString = recipesRequestModel.includeIngredients.map {
                $0.name} .joined(separator: ",")
            let mealsString = recipesRequestModel.meals.getSelected().joined(separator: ",")
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
                    "maxFat": recipesRequestModel.maxFat,
                    "type": mealsString
                ],
                encoding: URLEncoding.queryString)
        case .getRecipeInformation, .getSimilarRecipes:
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
        case .getRecipeInformationBulk(let ids):
            let idsString = ids.map { String($0) }.joined(separator: ", ")
            return .requestParameters(
                parameters: ["ids": idsString],
                encoding: URLEncoding.queryString
            )
        }
    }
}
