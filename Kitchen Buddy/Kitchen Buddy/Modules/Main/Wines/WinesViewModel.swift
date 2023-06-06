//
//  WinesViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import Swinject

class WinesViewModel {
    private let output: WinesModuleOutput?
    private let networkService: NetworkService
    private let wineLocalDataSource: WineModuleLocalDataSource
    private var wines = Wines(recommendedWines: [], totalFound: 0)
    private let selectedWineSort: WineSort
    private var isExpendedList: [Bool] = []
    
    init(
        networkService: NetworkService,
        wineLocalDataSource: WineModuleLocalDataSource,
        output: WinesModuleOutput?,
        sortValue: String
    ) {
        self.networkService = networkService
        self.wineLocalDataSource = wineLocalDataSource
        self.output = output
        guard let selectedWineSort = wineLocalDataSource.getWineSort(sortValue: sortValue) else {
            fatalError("error with swithing to wines module")
        }
        self.selectedWineSort = selectedWineSort
    }
    
    func viewDidLoadEvent(completion: @escaping () -> Void) {
        networkService.sendRequest(
            target: .getWines(
                sortName: selectedWineSort.value
            )
        ) { [weak self] (result: Result<Wines, Error>) in
            switch  result {
            case .success(let response):
                self?.wines = response
                self?.isExpendedList = response.recommendedWines.map { _ in false }
            case .failure(let error):
                print(String(describing: error))
            }
            completion()
        }
    }
    
    func getWinesCount() -> Int {
        return wines.totalFound
    }
    
    func getWine(indexPath: IndexPath) -> Wine {
        return wines.recommendedWines[indexPath.row]
    }
    
    func getWineSortTitle() -> String {
        return selectedWineSort.title
    }
    
    func didExpended(at row: Int) {
        isExpendedList[row] = !isExpendedList[row]
    }
    
    func isExpended(at row: Int) -> Bool {
        return isExpendedList[row]
    }
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
}
