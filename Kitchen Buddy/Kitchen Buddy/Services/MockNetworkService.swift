import Foundation

class MockNetworkService: NetworkServiceProtocol{
    
    func getRandomRecipes(completion: @escaping (Result<RandomRecipes, Error>) -> Void){
    }
    
    func getWines(sortName: String, completion: @escaping (Result<Wines, Error>) -> Void) {
    }
    
    func getIngredients(letters: String, offset: Int, completion: @escaping (Result<FoundIngredients, Error>) -> Void) {
    }
    
    func getRecipeInformation(recipeId: Int, completion: @escaping (Result<Recipe, Error>) -> Void) {
    }
    
    func getRecipes(includeIngredients: [String], sortBy: SortingParam, cusines: [CuisineType], diet: DietType, minCalories: Int, maxCalories: Int, minFat: Int, maxFat: Int, minCarbohydrates: Int, maxCarbohydrates: Int, minProtein: Int, maxProtein: Int, time: Int, intolerances: [IntoleranceType], completion: @escaping (Result<SearchRecipes, Error>) -> Void) {
    }
    
    func getRecipesByName(query: String, includeIngredients: [String], sortBy: SortingParam, cusines: [CuisineType], diet: DietType, minCalories: Int, maxCalories: Int, minFat: Int, maxFat: Int, minCarbohydrates: Int, maxCarbohydrates: Int, minProtein: Int, maxProtein: Int, time: Int, intolerances: [IntoleranceType], completion: @escaping (Result<SearchRecipes, Error>) -> Void) {
    }
}
