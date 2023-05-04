//
//  RecipeInfoViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import UIKit

class RecipeInfoViewController: UIViewController {
    private var viewModel: RecipeInfoViewModel

    private var recipeInfoButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 180, width: 200, height: 50)
        button.setTitle("Go to recipe info", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(recipeInfoButtonTapped), for: .touchUpInside)
        return button
    }
    
    init(viewModel: RecipeInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(recipeInfoButton)
    }
    
    @objc private func recipeInfoButtonTapped() {
        viewModel.showRecipeInfo()
    }
}