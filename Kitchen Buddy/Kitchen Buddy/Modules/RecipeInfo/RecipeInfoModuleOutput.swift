//
//  RecipeInfoModuleOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

protocol RecipeInfoModuleOutput: AnyObject {
    func showRecipeInfo()
    func viewDidPop(animated: Bool, completion: (() -> Void)?)
    func moduleDidUnload()
}
