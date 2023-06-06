//
//  SelectionViewModelProtocol .swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 06.06.2023.
//

protocol SelectionViewModelProtocol: AnyObject {
    func getSections() -> [Section]
    func getSectionCount() -> Int
    func showRecipeInfo(id: Int)
    func getRecipe(at row: Int) -> Recipe
    func getCountOfItemsInSection(sectionNumber: Int) -> Int
}
