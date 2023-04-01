import Foundation

protocol NetworkServiceProtocol{
    func getRandomRecipes(completion: @escaping (Result<RandomRecipes, Error>) -> Void)
    func getWines(sortName: String, completion: @escaping (Result<Wines, Error>) -> Void)
    func getIngredients(letters: String, offset: Int, completion: @escaping (Result<FoundIngredients, Error>) -> Void)
    func getRecipeInformation(recipeId: Int, completion: @escaping (Result<Recipe, Error>) -> Void)
    func getRecipes(includeIngredients: [String], sortBy: SortingParam, cusines: [CuisineType], diet: DietType, minCalories: Int, maxCalories: Int, minFat: Int, maxFat: Int,minCarbohydrates: Int, maxCarbohydrates: Int, minProtein: Int, maxProtein: Int, time: Int, intolerances: [IntoleranceType], completion: @escaping (Result<SearchRecipes, Error>) -> Void)
    func getRecipesByName(query:String, includeIngredients: [String], sortBy: SortingParam, cusines: [CuisineType], diet: DietType, minCalories: Int, maxCalories: Int, minFat: Int, maxFat: Int,minCarbohydrates: Int, maxCarbohydrates: Int, minProtein: Int, maxProtein: Int, time: Int, intolerances: [IntoleranceType], completion: @escaping (Result<SearchRecipes, Error>) -> Void)
}


class NetworkService: NetworkServiceProtocol{

    
        
    static let shared = NetworkService()
    private let baseURl = "https://api.spoonacular.com/"
        
    enum APIError: Error {
        case failedToGetData
        case failedToGetURL
    }
    
    private func createRequest<T: Decodable>(apiURL: String, completion: @escaping (Result<T, Error>) -> Void) {
        print(baseURl + apiURL)
        let encodedString = (baseURl + apiURL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: encodedString!) else {
            print(baseURl + apiURL)
            completion(.failure(APIError.failedToGetURL))
            return }
        var myRequest = URLRequest(url: url)
        myRequest.httpMethod = "GET"
        myRequest.setValue("", forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: myRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getRandomRecipes(completion: @escaping (Result<RandomRecipes, Error>) -> Void) {
        createRequest(apiURL: "recipes/random?number=100", completion: completion)
    }
    
    func getWines(sortName: String, completion: @escaping (Result<Wines, Error>) -> Void) {
        createRequest(apiURL: "food/wine/recommendation?wine=\(sortName)&number=100", completion: completion)
    }
    
    func getIngredients(letters: String, offset: Int, completion: @escaping (Result<FoundIngredients, Error>) -> Void) {
        createRequest(apiURL: "food/ingredients/search?query=\(letters)&offset=\(offset)", completion: completion)
    }
    
    func getRecipeInformation(recipeId: Int, completion: @escaping (Result<Recipe, Error>) -> Void) {
        createRequest(apiURL: "recipes/\(recipeId)/information", completion: completion)
    }
    
    func getRecipes(includeIngredients: [String], sortBy: SortingParam, cusines: [CuisineType], diet: DietType, minCalories: Int, maxCalories: Int, minFat: Int, maxFat: Int,minCarbohydrates: Int, maxCarbohydrates: Int, minProtein: Int, maxProtein: Int, time: Int, intolerances: [IntoleranceType], completion: @escaping (Result<SearchRecipes, Error>) -> Void) {
        let cusinesString = cusines.map { $0.rawValue } .joined(separator: ",")
        let intolerancesString = intolerances.map { $0.rawValue } .joined(separator: ",")
        let includeIngredientsString = includeIngredients.joined(separator: ",")
        createRequest(apiURL: "recipes/complexSearch?includeIngredients=\(includeIngredientsString)&sort=\(sortBy.rawValue)&cuisine=\(cusinesString)&diet=\(diet.rawValue)&intolerances=\(intolerancesString)&maxReadyTime=\(time)&minCarbs=\(minCarbohydrates)&maxCarbs=\(maxCarbohydrates)&minProtein=\(minProtein)&maxProtein=\(maxProtein)&minCalories=\(minCalories)&maxCalories=\(maxCalories)&minFat=\(minFat)&maxFat=\(maxFat)", completion: completion)
    }
    
    func getRecipesByName(query:String, includeIngredients: [String], sortBy: SortingParam, cusines: [CuisineType], diet: DietType, minCalories: Int, maxCalories: Int, minFat: Int, maxFat: Int,minCarbohydrates: Int, maxCarbohydrates: Int, minProtein: Int, maxProtein: Int, time: Int, intolerances: [IntoleranceType], completion: @escaping (Result<SearchRecipes, Error>) -> Void) {
        let cusinesString = cusines.map { $0.rawValue } .joined(separator: ",")
        let intolerancesString = intolerances.map { $0.rawValue } .joined(separator: ",")
        let includeIngredientsString = includeIngredients.joined(separator: ",")
        createRequest(apiURL: "recipes/complexSearch?query=\(query)&includeIngredients=\(includeIngredientsString)&sort=\(sortBy.rawValue)&cuisine=\(cusinesString)&diet=\(diet.rawValue)&intolerances=\(intolerancesString)&maxReadyTime=\(time)&minCarbs=\(minCarbohydrates)&maxCarbs=\(maxCarbohydrates)&minProtein=\(minProtein)&maxProtein=\(maxProtein)&minCalories=\(minCalories)&maxCalories=\(maxCalories)&minFat=\(minFat)&maxFat=\(maxFat)", completion: completion)
    }
}

