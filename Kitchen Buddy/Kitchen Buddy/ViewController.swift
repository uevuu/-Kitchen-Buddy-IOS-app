import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        // MARK: - Test Network Service

        NetworkService.shared.getRecipes(includeIngredients: ["water, carrot"],sortBy: .None, cusines: [], diet: .NotDiet, minCalories: 0, maxCalories: 800, minFat: 0, maxFat: 800, minCarbohydrates: 0, maxCarbohydrates: 800, minProtein: 0, maxProtein: 800, time: 50, intolerances: [.Gluten]) { result in
            switch result {
            case .success(let recipes):
                for i in recipes.results {
                    print(i.title)
                    print(i.nutrition)
                }
                print(recipes)
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
        NetworkService.shared.getRecipesByName(query: "Af",includeIngredients: ["water, carrot"],sortBy: .None, cusines: [], diet: .NotDiet, minCalories: 0, maxCalories: 800, minFat: 0, maxFat: 800, minCarbohydrates: 0, maxCarbohydrates: 800, minProtein: 0, maxProtein: 800, time: 50, intolerances: [.Gluten]) { result in
            switch result {
            case .success(let recipes):
                print(recipes)
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
        NetworkService.shared.getRandomRecipes { result in
            switch result {
            case .success(let recipes):
                for recipe in recipes.recipes{
                        print(recipe.title)
                }
            case .failure(let error):
                    print(String(describing: error))
            }
        }

        NetworkService.shared.getWines(sortName: "merlot") { result in
            switch result {
            case .success(let wines):
                for wine in wines.recommendedWines{
                    print(wine.title)
                }
                case .failure(let error):
                        print(String(describing: error))
            }
        }

        NetworkService.shared.getIngredients(letters: "a", offset: 12) { result in
            switch result {
            case .success(let ingredients):
                for ingredient in ingredients.results {
                    print(ingredient.name)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }

        NetworkService.shared.getRecipeInformation(recipeId: 6523) { result in
            switch result {
            case .success(let recipe):
                if !recipe.analyzedInstructions.isEmpty {
                    for step in recipe.analyzedInstructions.first!.steps{
                        print(step.number)
                        print(step.step)
                    }
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

