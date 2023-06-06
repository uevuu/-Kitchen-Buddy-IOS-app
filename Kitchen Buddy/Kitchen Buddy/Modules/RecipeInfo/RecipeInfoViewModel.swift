//
//  RecipeInfoViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import Swinject

class RecipeInfoViewModel {
    private let output: RecipeInfoModuleOutput?
    private let networkService: NetworkService
    private let  recipeModuleLocalDataSource: RecipeModuleLocalDataSource
    private let lastRecipesService: LastRecipesService
    private let favouriteService: FavouriteService
    private var selectedRecipe: Recipe
    private var similarRecipes: [Recipe]?
    
    private var sections: [Section] = [
        RecipeInfoSection(),
        RecipeInstructionSection(),
        SelectionRecipeSection()
    ]
    
    init(
        networkService: NetworkService,
        recipeModuleLocalDataSource: RecipeModuleLocalDataSource,
        lastRecipesService: LastRecipesService,
        favouriteService: FavouriteService,
        output: RecipeInfoModuleOutput?,
        recipeId: Int
    ) {
        self.networkService = networkService
        self.recipeModuleLocalDataSource = recipeModuleLocalDataSource
        self.lastRecipesService = lastRecipesService
        self.favouriteService = favouriteService
        guard let selectedRecipe = recipeModuleLocalDataSource.getRecipe(id: recipeId) else {
            fatalError("error with swithing to recipe info module")
        }
        self.selectedRecipe = selectedRecipe
        self.output = output
    }
    
    func viewDidLoadEvent(completion: @escaping () -> Void) {
        lastRecipesService.saveRecipe(recipe: selectedRecipe)
        networkService.sendRequest(
            target: .getSimilarRecipes(
                recipeId: selectedRecipe.id
            )
        ) { [weak self] (result: Result<[SimilarRecipe], Error>) in
            switch result {
            case .success(let recipes):
                let ids = recipes.map { $0.id }
                self?.networkService.sendRequest(
                    target: .getRecipeInformationBulk(
                        ids: ids
                    )
                ) { [weak self] (result: Result<[Recipe], Error>) in
                    switch result {
                    case .success(let recipes):
                        self?.similarRecipes = recipes
                    case .failure(let error):
                        print(String(describing: error))
                    }
                    completion()
                }
            case .failure(let error):
                print(String(describing: error))
                completion()
            }
        }
    }
    
    func getRecipeTitle() -> String {
        return selectedRecipe.title
    }
    
    func getRecipe() -> Recipe {
        return selectedRecipe
    }
    
    func getStep(stepNumber: Int) -> Step? {
        return selectedRecipe.analyzedInstructions.first?.steps[stepNumber]
    }
    
    func getSimilarRecipe(recipeNumber: Int) -> Recipe? {
        return similarRecipes?[recipeNumber]
    }
    
    func getSections() -> [Section] {
        return sections
    }
    
    func getSectionCount() -> Int {
        return sections.count
    }
    
    func getCountOfItemsInSection(sectionNumber: Int) -> Int {
        if sectionNumber == 0 {
            return 1
        } else if sectionNumber == 1 {
            return selectedRecipe.analyzedInstructions.first?.steps.count ?? 0
        } else {
            return similarRecipes?.count ?? 0
        }
    }
    
    func tapOnStarButton() {
        if !favouriteService.recipeIsAdded(selectedRecipe) {
            favouriteService.saveRecipe(selectedRecipe)
        } else {
            favouriteService.deleteRecipe(selectedRecipe)
        }
    }
    
    func setImage() -> UIImage? {
        if favouriteService.recipeIsAdded(selectedRecipe) {
            return UIImage(systemName: "star.fill")
        }
        return UIImage(systemName: "star")
    }
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func selectSimilarRecipe(recipeNumber: Int) {
        if let id = similarRecipes?[recipeNumber].id {
            recipeModuleLocalDataSource.saveRecipes(similarRecipes)
            output?.showSimilarRecipe(recipeId: id)
        }
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
}
