//
//  MainViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import UIKit

final class MainViewController: UIViewController {
    private var viewModel: MainViewModel
            
    private var recipeButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 120, width: 100, height: 50)
        button.setTitle("Recipe", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(recipeTapped), for: .touchUpInside)
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
        view.addSubview(recipeButton)
    }
        
    @objc func recipeTapped(sender: UIButton!) {
        viewModel.seeRecipeInfo()
    }
}
