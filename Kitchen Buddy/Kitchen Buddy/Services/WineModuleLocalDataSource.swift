//
//  WineModuleLocalDataSource.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 27.05.2023.
//

import Foundation

class WineModuleLocalDataSource {
    private let winesSort: [[WineSort]]
    
    init() {
        self.winesSort = Bundle.main.decode(file: "WinesSort.json")
    }
    
    func getWineSort(sortValue: String) -> WineSort? {
        return winesSort.flatMap { $0 }.first { $0.value == sortValue }
    }
    
    func getWinesSort() -> [[WineSort]] {
        return winesSort
    }
}
