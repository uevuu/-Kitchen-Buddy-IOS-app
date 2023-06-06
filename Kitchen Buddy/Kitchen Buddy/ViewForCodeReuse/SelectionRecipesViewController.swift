//
//  SelectionRecipesViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 06.06.2023.
//

import UIKit
import SnapKit

class SelectionRecipesViewController: UIViewController {
    var viewModel: SelectionViewModelProtocol
    
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
    init(viewModel: SelectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setuCollectionView()
    }
    
    // MARK: - Setups
    private func setuCollectionView() {
        view.backgroundColor = UIColor(named: "AppBackgroundColor")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets)
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension SelectionRecipesViewController: UICollectionViewDataSource {
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

extension SelectionRecipesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = viewModel.getRecipe(at: indexPath.row)
        viewModel.showRecipeInfo(id: recipe.id)
    }
}
