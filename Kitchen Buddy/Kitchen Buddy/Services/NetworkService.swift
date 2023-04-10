import Moya

protocol NetworkServiceProtocol {
    var provider: MoyaProvider<MoyaAPIService> { get }
    func getRandomRecipes(completion: @escaping (Result<RandomRecipes, Error>) -> Void)
    func getWines(sortName: String, completion: @escaping (Result<Wines, Error>) -> Void)
    func getIngredients(letters: String, offset: Int, completion: @escaping (Result<FoundIngredients, Error>) -> Void)
    func getRecipeInformation(recipeId: Int, completion: @escaping (Result<Recipe, Error>) -> Void)
    func getRecipes(
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
        intolerances: [IntoleranceType],
        completion: @escaping (Result<SearchRecipes, Error>) -> Void
    )
}

class NetworkService: NetworkServiceProtocol {
    var provider = MoyaProvider<MoyaAPIService>()
    static let shared = NetworkService()
    
    func getRandomRecipes(completion: @escaping (Result<RandomRecipes, Error>) -> Void) {
        createRequest(target: .getRandomRecipes, completion: completion)
    }
    
    func getWines(sortName: String, completion: @escaping (Result<Wines, Error>) -> Void) {
        createRequest(target: .getWines(sortName: sortName), completion: completion)
    }
    
    func getIngredients(letters: String, offset: Int, completion: @escaping (Result<FoundIngredients, Error>) -> Void) {
        createRequest(target: .getIngredients(letters: letters, offset: offset), completion: completion)
    }
    
    func getRecipeInformation(recipeId: Int, completion: @escaping (Result<Recipe, Error>) -> Void) {
        createRequest(target: .getRecipeInformation(recipeId: recipeId), completion: completion)
    }
    
    func getRecipes(
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
        intolerances: [IntoleranceType],
        completion: @escaping (Result<SearchRecipes, Error>) -> Void
    ) {
        createRequest(
            target: .getRecipes(
                query: query,
                includeIngredients: includeIngredients,
                sortBy: sortBy,
                cusines: cusines,
                diet: diet,
                minCalories: minCalories,
                maxCalories: maxCalories,
                minFat: minFat,
                maxFat: maxFat,
                minCarbohydrates: minCarbohydrates,
                maxCarbohydrates: maxCarbohydrates,
                minProtein: minProtein,
                maxProtein: maxProtein,
                time: time,
                intolerances: intolerances
            ),
            completion: completion
        )
    }
    
    private func createRequest<T: Decodable>(
        target: MoyaAPIService,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let result = try JSONDecoder().decode(T.self, from: moyaResponse.data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
