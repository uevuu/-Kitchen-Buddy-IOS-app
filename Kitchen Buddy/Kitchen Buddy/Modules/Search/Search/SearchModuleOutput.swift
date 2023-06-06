//
//  SearchModuleOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import Foundation

// MARK: - SearchModuleOutput
protocol SearchModuleOutput: AnyObject {
    func showFilter()
    func showRecipeInfo(id: Int)
}
