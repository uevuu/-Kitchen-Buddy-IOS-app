//
//  AllSelectionRecipesViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.05.2023.
//

import UIKit
import SnapKit

final class AllSelectionRecipesViewController: UIViewController {
    // MARK: - Dependencies
    private var viewModel: AllSelectionRecipesViewModel
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "AppBackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            RecipeCell.self,
            forCellWithReuseIdentifier: RecipeCell.reuseIdentifier
        )

        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = viewModel.getSections()
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    
    // MARK: - Init
    init(viewModel: AllSelectionRecipesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        setupViews()
    }
    
    deinit {
        viewModel.controllerWasDeinit()
    }
    
    // MARK: - Setups
    private func setupViews() {
        title = "Recipes"
        view.backgroundColor = UIColor(named: "AppBackgroundColor")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets)
        }
    }
    
    private func configureItems() {
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
        viewModel.tapOnBackButton()
    }
}

extension AllSelectionRecipesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountOfItemsInSection(sectionNumber: section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCell.reuseIdentifier,
            for: indexPath
        ) as? RecipeCell else {
            fatalError("error")
        }
        let recipe = viewModel.getRecipe(at: indexPath.row)
        cell.configureCell(recipe: recipe)
        return cell
    }
}

extension AllSelectionRecipesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = viewModel.getRecipe(at: indexPath.row)
        viewModel.showRecipeInfo(id: recipe.id)
    }
}
