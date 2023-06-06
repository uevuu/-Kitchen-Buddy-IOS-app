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
            return filterService.getDietsCount()
        case .meal:
            return filterService.getMealssCount()
        case .cusine:
            return filterService.getCusinedCount()
        case .intolerance:
            return filterService.getIntolerancesCount()
        }
    }
    
    func getCellData(at row: Int) -> SelectableSettingModel {
        switch settingType {
        case .diet:
            return filterService.getDiet(at: row)
        case .meal:
            return filterService.getMeal(at: row)
        case .cusine:
            return filterService.getCusine(at: row)
        case .intolerance:
            return filterService.getIntolerance(at: row)
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
            filterService.swapDietStatus(at: row)
        case .meal:
            filterService.swapMealStatus(at: row)
        case .cusine:
            filterService.swapCusineStatus(at: row)
        case .intolerance:
            filterService.swapIntoleranceStatus(at: row)
        }
    }
}
