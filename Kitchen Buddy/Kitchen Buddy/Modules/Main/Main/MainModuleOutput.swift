//
//  MainModuleOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

protocol MainModuleOutput: AnyObject {
    func showAllWinesThisSort(sortValue: String)
    func showRecipeInfo(id: Int)
    func showAllSelectionRecipes()
    func showSettings()
//    func viewDidPop(animated: Bool, completion: (() -> Void)?)
//    func moduleDidUnload()
}
