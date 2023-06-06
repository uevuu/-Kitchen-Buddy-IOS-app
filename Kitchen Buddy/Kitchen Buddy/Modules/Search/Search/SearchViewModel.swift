//
//  SearchViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import Foundation

// MARK: - SearchViewModel
class SearchViewModel {
    private weak var output: SearchModuleOutput?
    private let networkService: NetworkService
    private let filterService: FilterService
    private var foundRecipes: [SearchRecipe] = []
    private var foundIngredients: [Ingredient] = []
    private let recipeLocalDataSource: RecipeModuleLocalDataSource
    
    private var totalObjects = 0
    private var offset = 0
    private var currQuery: String?
    private var isLoadingNext = false
    
    var desiredObject: SearchTypes = .recipe
    
    enum SearchTypes {
        case ingredient
        case recipe
    }
    
    // MARK: - Init
    init(
        networkService: NetworkService,
        filterService: FilterService,
        recipeLocalDataSource: RecipeModuleLocalDataSource,
        output: SearchModuleOutput?
    ) {
        self.networkService = networkService
        self.filterService = filterService
        self.recipeLocalDataSource = recipeLocalDataSource
        self.output = output
    }
        
    func viewDidLoadEvent(completion: @escaping () -> Void) {
        offset = 0
    }
    
    func searchData(query: String, completion: @escaping () -> Void) {
        switch desiredObject {
        case .ingredient:
            searchIngredients(query: query, completion: completion)
        case .recipe:
            searchRecipes(query: query, completion: completion)
        }
    }
    
    func searchIngredients(query: String, completion: @escaping () -> Void) {
        offset = 0
        currQuery = query
        isLoadingNext = true
        networkService.sendRequest(
            target: .getIngredients(
                letters: query,
                offset: offset
            )
        ) { [weak self] (result: Result<FoundIngredients, Error>) in
            switch result {
            case .success(let ingredients):
                self?.foundIngredients = ingredients.results
                self?.totalObjects = ingredients.totalResults
                self?.offset = ingredients.results.count
            case .failure(let error):
                print(String(describing: error))
            }
            completion()
        }
    }
    
    func searchRecipes(query: String, completion: @escaping () -> Void) {
        networkService.sendRequest(
            target: .getRecipes(
                recipesRequestModel: filterService.getFilters(with: query)
            )
        ) { [weak self] (result: Result<SearchRecipes, Error>) in
            switch result {
            case .success(let recipes):
                self?.foundRecipes = recipes.results
                self?.totalObjects = recipes.totalResults
                self?.offset = recipes.results.count
            case .failure(let error):
                print(String(describing: error))
            }
            completion()
        }
    }
    
    func getSectionCount() -> Int {
        return 1
    }
    
    func isTapped() -> Bool {
        switch desiredObject {
        case .ingredient:
            return false
        case .recipe:
            return true
        }
    }
    
    func getCountOfItemsInSection(sectionNumber: Int) -> Int {
        let includeIngredients = filterService.getIncludeIngredients()
        return includeIngredients.count
    }
    
    func getCountOfFoundData() -> Int {
        switch desiredObject {
        case .ingredient:
            return foundIngredients.count
        case .recipe:
            return foundRecipes.count
        }
    }
    
    func getFoundIngredient(at row: Int) -> Ingredient {
        return foundIngredients[row]
    }
    
    func getFoundRecipes(at row: Int) -> SearchRecipe {
        return foundRecipes[row]
    }
    
    func isIncludedIngredient(_ ingredient: Ingredient) -> Bool {
        let includeIngredients = filterService.getIncludeIngredients()
        return includeIngredients.contains { $0.id == ingredient.id }
    }
    
    func addIngedient(at row: Int) {
        filterService.addIngredient(foundIngredients[row])
    }
    
    func removeIngedient(at row: Int) {
        filterService.removeIngedient(at: row)
    }
    
    func getCountOfIncludeIngredients() -> Int {
        return filterService.getIncludeIngredientsCount()
    }
    
    func getIncludeIngredient(at row: Int) -> Ingredient {
        return filterService.getIncludeIngredient(at: row)
    }
    
    func deleteIncludeIngredient(at row: Int, completion: @escaping () -> Void) {
        filterService.removeIngedient(at: row)
        completion()
    }
    
    func cleanFoundObjects() {
        switch desiredObject {
        case .ingredient:
            foundIngredients.removeAll()
        case .recipe:
            foundRecipes.removeAll()
        }
        desiredObject = .recipe
    }
    
    func handleTapOnRecipe(at row: Int) {
        networkService.sendRequest(
            target: .getRecipeInformationBulk(
                ids: [foundRecipes[row].id]
            )
        ) { [weak self] (result: Result<[Recipe], Error>) in
            switch result {
            case .success(let recipes):
                self?.recipeLocalDataSource.saveRecipes(recipes)
            case .failure(let error):
                print(String(describing: error))
            }
            if let recipeId = self?.foundRecipes[row].id {
                self?.output?.showRecipeInfo(id: recipeId)
            }
        }
    }
    
    func goToFilterModule() {
        output?.showFilter()
    }
}
