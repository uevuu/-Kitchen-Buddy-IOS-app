//
//  FilterViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import Foundation

class FilterSection {
    let name: String
    let options: [String]
    var isOpened = false
    
    init(name: String, options: [String]) {
        self.name = name
        self.options = options
    }
}

// MARK: - FilterViewModel
class FilterViewModel {
    private let networkService: NetworkService
    private let filterService: FilterService
    private let output: FilterModuleOutput?
    private let selectableSetting = ["Diet", "Meal", "Cusine", "Intolerance"]
    private let sortingParams = ["None", "Price", "Popularity", "Time"]

    init(
        networkService: NetworkService,
        filterService: FilterService,
        output: FilterModuleOutput?
    ) {
        self.networkService = networkService
        self.filterService = filterService
        self.output = output
    }
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
    
    func selectableSettingCount() -> Int {
        return selectableSetting.count
    }
    
    func getCellSetting(at row: Int) -> SelectableSetting {
        switch row {
        case 0:
            return SelectableSetting(
                title: selectableSetting[row],
                selectedData: filterService.filters.diet.getSelected()
            )
        case 1:
            return SelectableSetting(
                title: selectableSetting[row],
                selectedData: filterService.filters.meals.getSelected()
            )
        case 2:
            return SelectableSetting(
                title: selectableSetting[row],
                selectedData: filterService.filters.cusines.getSelected()
            )
        case 3:
            return SelectableSetting(
                title: selectableSetting[row],
                selectedData: filterService.filters.intolerances.getSelected()
            )
        default:
            return SelectableSetting(
                title: "",
                selectedData: []
            )
        }
    }
    func getSortingParam() -> Int {
        return sortingParams.firstIndex { $0 == filterService.filters.sortBy } ?? 0
    }
    
    func handleSortingParamChanged(index: Int) {
        filterService.filters.sortBy = sortingParams[index]
    }
    
    func showSelectableSetting(at row: Int) {
        switch row {
        case 0:
            output?.showSelectableSetting(.diet)
        case 1:
            output?.showSelectableSetting(.meal)
        case 2:
            output?.showSelectableSetting(.cusine)
        case 3:
            output?.showSelectableSetting(.intolerance)
        default:
            break
        }
    }
}
struct SelectableSetting {
    let title: String
    let selectedData: [String]
}
