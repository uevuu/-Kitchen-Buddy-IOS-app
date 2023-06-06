//
//  AllSelectionRecipesViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

import UIKit
import SnapKit

final class AllSelectionRecipesViewController: SelectionRecipesViewController {
    init(viewModel: AllSelectionRecipesViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        title = "Recipes"
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    // MARK: - Private
    @objc private func backButtonTapped() {
        if let viewModel = viewModel as? AllSelectionRecipesViewModel {
            viewModel.tapOnBackButton()
        }
    }
}
