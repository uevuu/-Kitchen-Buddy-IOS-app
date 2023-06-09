//
//  AllSelectionRecipesModuleOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

protocol AllSelectionRecipesModuleOutput: AnyObject {
    func showRecipeInfo(id: Int)
    func viewDidPop(animated: Bool, completion: (() -> Void)?)
    func moduleDidUnload()
}
