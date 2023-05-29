//
//  WineModuleLocalDataSource.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 27.05.2023.
//

class WineModuleLocalDataSource {
    private var wineSort: WineSort?
    private var wine: Wine?
    
    func saveWineSort(_ wineSort: WineSort) {
        self.wineSort = wineSort
    }
    
    func getWineSort() -> WineSort? {
        return wineSort
    }
    
    func saveWine(_ wine: Wine) {
        self.wine = wine
    }
    
    func getWine() -> Wine? {
        return wine
    }
}
