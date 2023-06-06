//
//  MainViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import Swinject

// MARK: - MainViewModel
class MainViewModel {
    private weak var output: MainModuleOutput?
    private let networkService: NetworkService
    private let lastRecipesService: LastRecipesService
    private let wineLocalDataSource: WineModuleLocalDataSource
    private let recipeModuleLocalDataSource: RecipeModuleLocalDataSource
    private var lastRecipes: [Recipe] = []
    private var winesSort: [[WineSort]] = [[]]
    private var allSelectionRecipes: [Recipe] = []
    private var selectionRecipes: [Recipe] = []
    
    private var sections: [Section] = [
        RecentRecipeSection(),
        SelectionRecipeSection(),
        WineSortSection(),
        WineSortSection(),
        WineSortSection()
    ]
    
    // MARK: - Init
    init(
        networkService: NetworkService,
        lastRecipesService: LastRecipesService,
        wineLocalDataSource: WineModuleLocalDataSource,
        recipeModuleLocalDataSource: RecipeModuleLocalDataSource,
        output: MainModuleOutput?
    ) {
        self.networkService = networkService
        self.lastRecipesService = lastRecipesService
        self.wineLocalDataSource = wineLocalDataSource
        self.recipeModuleLocalDataSource = recipeModuleLocalDataSource
        self.output = output
    }
        
    func viewDidLoadEvent(completion: @escaping () -> Void) {
        winesSort = wineLocalDataSource.getWinesSort()
        lastRecipes = lastRecipesService.getRecipes()
        networkService.sendRequest(
            target: .getRandomRecipes
        ) { [weak self] (result: Result<RandomRecipes, Error>) in
            switch  result {
            case .success(let recipes):
                self?.selectionRecipes = Array(recipes.recipes.prefix(20))
                self?.allSelectionRecipes = recipes.recipes
            case .failure(let error):
                print(String(describing: error))
            }
            completion()
        }
    }
    
    func reloadLastRecipes(completion: @escaping () -> Void) {
        lastRecipes = LastRecipesService().getRecipes()
        completion()
    }
    
    func showAllSelectionRecipes() {
        recipeModuleLocalDataSource.saveRecipes(allSelectionRecipes)
        output?.showAllSelectionRecipes()
    }
    
    func showSettings() {
        output?.showSettings()
    }
    
    func getSections() -> [Section] {
        return sections
    }
    
    func getNumberOfSections() -> Int {
        return sections.count
    }
    
    func getCountOfItemsInSection(sectionNumber: Int) -> Int {
        if sectionNumber == 0 {
            return lastRecipes.count
        } else if sectionNumber == 1 {
            return selectionRecipes.count
        } else {
            return winesSort[sectionNumber - 2].count
        }
    }
    
    func getSection(indexPath: IndexPath) -> Section {
        return sections[indexPath.section]
    }
    
    func getOneOfLastRecipes(itemNumber: Int) -> Recipe {
        return lastRecipes[itemNumber]
    }
    
    func getOneOfSelectionRecipes(itemNumber: Int) -> Recipe {
        return selectionRecipes[itemNumber]
    }
    
    func getWineSort(indexPath: IndexPath) -> WineSort {
        return winesSort[indexPath.section - 2][indexPath.item]
    }
    
    func handleDidSelectItemAt(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let recipe = lastRecipes[indexPath.item]
            recipeModuleLocalDataSource.saveRecipes(lastRecipes)
            output?.showRecipeInfo(id: recipe.id)
        case 1:
            let recipe = selectionRecipes[indexPath.item]
            recipeModuleLocalDataSource.saveRecipes(allSelectionRecipes)
            output?.showRecipeInfo(id: recipe.id)
        case 2, 3, 4:
            let wineSort = winesSort[indexPath.section - 2][indexPath.item]
            output?.showAllWinesThisSort(sortValue: wineSort.value)
        default:
            break
        }
    }
}
