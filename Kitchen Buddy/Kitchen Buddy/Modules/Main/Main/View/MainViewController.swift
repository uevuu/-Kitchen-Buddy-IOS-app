//
//  MainViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import UIKit

final class MainViewController: UIViewController {
    private var viewModel: MainViewModel
            
    private var winesButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 120, width: 200, height: 50)
        button.setTitle("Go to Wines collection", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(winesButtonTapped), for: .touchUpInside)
        return button
    }
    
    private var recipeInfoButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 180, width: 200, height: 50)
        button.setTitle("Go to recipe info", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(recipeInfoButtonTapped), for: .touchUpInside)
        return button
    }
    
    private var allRecipesButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 240, width: 200, height: 50)
        button.setTitle("Go to all recipes", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(allRecipesButtonTapped), for: .touchUpInside)
        return button
    }
    
    private var settingsButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 300, width: 200, height: 50)
        button.setTitle("Setting", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(winesButton)
        view.addSubview(recipeInfoButton)
        view.addSubview(allRecipesButton)
        view.addSubview(settingsButton)
    }
        
    @objc private func winesButtonTapped() {
        viewModel.showAllWinesThisSort()
    }
    
    @objc private func recipeInfoButtonTapped() {
        viewModel.showRecipeInfo()
    }
    
    @objc private func allRecipesButtonTapped() {
        viewModel.showAllSelectionRecipes()
    }
    
    @objc private func settingsButtonTapped() {
        viewModel.showSettings()
    }
}
