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
    private var selectedRecipe: Recipe
    
    private var sections: [Section] = [
        RecipeInfoSection(),
        RecipeInstructionSection(),
        SimilarRecipesSection()
    ]
    
    init(
        networkService: NetworkService,
        recipeModuleLocalDataSource: RecipeModuleLocalDataSource,
        lastRecipesService: LastRecipesService,
        output: RecipeInfoModuleOutput?
    ) {
        self.networkService = networkService
        self.recipeModuleLocalDataSource = recipeModuleLocalDataSource
        self.lastRecipesService = lastRecipesService
        guard let selectedRecipe = recipeModuleLocalDataSource.getRecipe() else {
            fatalError("error with swithing to recipe info module")
        }
        self.selectedRecipe = selectedRecipe
        self.output = output
    }
    
    func viewDidLoadEvent(completion: @escaping () -> Void) {
        //        wines = Bundle.main.decode(file: "WInesData.json")
        //        completion()
        //        networkService.sendRequest(
        //            target: .getWines(
        //                sortName: selectedWineSort.value
        //            )
        //        ) { [weak self] (result: Result<Wines, Error>) in
        //            switch  result {
        //            case .success(let response):
        //                self?.wines = response
        //            case .failure(let error):
        //                print(String(describing: error))
        //            }
        //            completion()
        //        }
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
            return 10
        }
    }
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func tapOnRecipe() {
        output?.showRecipeInfo()
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
}
