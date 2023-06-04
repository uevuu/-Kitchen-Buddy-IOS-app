//
//  SelectableSettingViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import Foundation

// MARK: - SelectableSettingViewModel
class SelectableSettingViewModel {
    private let filterService: FilterService
    private let settingType: SelectableSettingType
    private let output: SelectableSettingOutput?

    init(
        settingType: SelectableSettingType,
        filterService: FilterService,
        output: SelectableSettingOutput?
    ) {
        self.settingType = settingType
        self.filterService = filterService
        self.output = output
    }
    
    func tapOnBackButton() {
        output?.viewDidPop(animated: true, completion: nil)
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
    
    func getSettingCount() -> Int {
        switch settingType {
        case .diet:
            return filterService.filters.diet.count
        case .meal:
            return filterService.filters.meals.count
        case .cusine:
            return filterService.filters.cusines.count
        case .intolerance:
            return filterService.filters.intolerances.count
        }
    }
    
    func getCellData(at row: Int) -> SelectableSettingModel {
        switch settingType {
        case .diet:
            return filterService.filters.diet[row]
        case .meal:
            return filterService.filters.meals[row]
        case .cusine:
            return filterService.filters.cusines[row]
        case .intolerance:
            return filterService.filters.intolerances[row]
        }
    }
    
    func getTitle() -> String {
        switch settingType {
        case .diet:
            return "Diets"
        case .meal:
            return "Meals"
        case .cusine:
            return "Cusines"
        case .intolerance:
            return "Intolerances"
        }
    }
    
    func cellTapped(at row: Int) {
        switch settingType {
        case .diet:
            filterService.filters.diet[row].isSelected.toggle()
        case .meal:
            filterService.filters.meals[row].isSelected.toggle()
        case .cusine:
            filterService.filters.cusines[row].isSelected.toggle()
        case .intolerance:
            filterService.filters.intolerances[row].isSelected.toggle()
        }
    }
}
