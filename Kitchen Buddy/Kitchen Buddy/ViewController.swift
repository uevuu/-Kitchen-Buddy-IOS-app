import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
                
        NetworkService.shared.getIngredients(letters: "ap", offset: 14) { result in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        NetworkService.shared.getRandomRecipes { result in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        NetworkService.shared.getRecipeInformation(recipeId: 6543) { result in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        NetworkService.shared.getWines(sortName: "merlot") { result in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }

        NetworkService.shared.getRecipes(
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
        ) { result in
            switch result {
            case let .success(ingredients):
                print(ingredients)
            case let .failure(error):
                print(String(describing: error))
            }
        }
    }
}
