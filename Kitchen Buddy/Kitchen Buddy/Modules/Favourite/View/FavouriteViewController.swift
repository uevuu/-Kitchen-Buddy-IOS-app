//
//  FavouriteViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 06.06.2023.
//

import UIKit

final class FavouriteViewController: SelectionRecipesViewController {
    init(viewModel: FavouriteViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let favouriteViewModel = viewModel as? FavouriteViewModel {
            favouriteViewModel.viewDidLoadEvent { [weak self] in
                self?.reloadCollectionView()
            }
        }
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let favouriteViewModel = viewModel as? FavouriteViewModel {
            favouriteViewModel.viewDidLoadEvent { [weak self] in
                self?.reloadCollectionView()
            }
        }
    }
    
    private func setupViews() {
        title = "Favourite"
    }
}
