import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        let service = NetworkService()
                
        service.createRequest(
            target: .getIngredients(
                letters: "ban",
                offset: 12
        )) { (result: Result<FoundIngredients, Error>) in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        service.createRequest(target: .getRandomRecipes) { (result: Result<RandomRecipes, Error>) in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        service.createRequest(target: .getRecipeInformation(recipeId: 6543)) { (result: Result<Recipe, Error>) in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        service.createRequest(target: .getWines(sortName: "merlot")) { (result: Result<Wines, Error>) in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        service.createRequest(
            target: .getRecipes(
                query: "Af",
                includeIngredients: ["water, carrot"],
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
                time: 50,
                intolerances: [.gluten]
            )
        ) { (result: Result<SearchRecipes, Error>) in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }
    }
}
