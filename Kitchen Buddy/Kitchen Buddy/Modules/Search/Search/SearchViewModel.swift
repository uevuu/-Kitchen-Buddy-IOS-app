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
    private var includeIngredients: [Ingredient] = []
    
    private var totalObjects = 0
    private var offset = 0
    private var currQuery: String?
    private var isLoadingNext = false
    
    var desiredObject: SearchTypes = .recipe
    
    private var sections: [Section] = [
        IngredientSection()
    ]
    
    enum SearchTypes {
        case ingredient
        case recipe
    }
    
    // MARK: - Init
    init(
        networkService: NetworkService,
        filterService: FilterService,
        output: SearchModuleOutput?
    ) {
        self.networkService = networkService
        self.filterService = filterService
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
        default:
            break
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
        print("search recipes")
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
        return sections.count
    }
    
    func getSections() -> [Section] {
        return sections
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
        return includeIngredients.contains { $0.id == ingredient.id }
    }
    
    func addIngedient(at row: Int) {
        if !(includeIngredients.contains { $0.id == foundIngredients[row].id }) {
            includeIngredients.append(foundIngredients[row])
        }
    }
    
    func removeIngedient(at row: Int) {
        includeIngredients.remove(at: row)
    }
    
    func getCountOfIncludeIngredients() -> Int {
        return includeIngredients.count
    }
    
    func getIncludeIngredient(at row: Int) -> Ingredient {
        return includeIngredients[row]
    }
    
    func deleteIncludeIngredient(at row: Int, completion: @escaping () -> Void) {
        includeIngredients.remove(at: row)
        completion()
    }
    
    func cleanFoundObjects() {
        switch desiredObject {
        case .ingredient:
            foundIngredients.removeAll()
        case .recipe:
            foundRecipes.removeAll()
        }
    }
}
