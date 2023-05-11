//
//  AllSelectionRecipesViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

import UIKit

class AllSelectionRecipesViewController: UIViewController {
    private var viewModel: AllSelectionRecipesViewModel
    
    private var recipeInfoButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 180, width: 200, height: 50)
        button.setTitle("Go to recipe info", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(recipeInfoButtonTapped), for: .touchUpInside)
        return button
    }
    
    init(viewModel: AllSelectionRecipesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(recipeInfoButton)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            viewModel.tapOnBackButton()
        }
    }
    
    deinit {
        viewModel.controllerWasDeinit()
    }
    
    @objc private func recipeInfoButtonTapped() {
        viewModel.showRecipeInfo()
    }
}
