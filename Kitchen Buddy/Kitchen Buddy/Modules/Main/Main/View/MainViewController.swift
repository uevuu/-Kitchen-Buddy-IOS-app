//
//  MainViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Dependencies
    private var viewModel: MainViewModel
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "AppBackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            RecentRecipeCell.self,
            forCellWithReuseIdentifier: RecentRecipeCell.reuseIdentifier
        )
        collectionView.register(
            SelectionRecipeCell.self,
            forCellWithReuseIdentifier: SelectionRecipeCell.reuseIdentifier
        )
        collectionView.register(
            WineSortCell.self,
            forCellWithReuseIdentifier: WineSortCell.reuseIdentifier
        )
        
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.reuseIdentifier
        )
        
        collectionView.register(
            SelectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SelectionHeaderView.reuseIdentifier
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 1 {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SelectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? SelectionHeaderView else {
                    fatalError("error")
                }
                header.configureCell(headerName: "Try this")
                header.setTargetForButton(
                    target: self,
                    action: #selector(allRecipesButtonTapped),
                    event: .touchUpInside
                )
                return header
            } else {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.reuseIdentifier,
                    for: indexPath
                ) as? HeaderView else {
                    fatalError("error")
                }
                if indexPath.section == 0 {
                    header.configureCell(headerName: "Hello")
                } else if indexPath.section == 2 {
                    header.configureCell(headerName: "White wines")
                } else if indexPath.section == 3 {
                    header.configureCell(headerName: "Red Wines")
                } else if indexPath.section == 4 {
                    header.configureCell(headerName: "Other Wines")
                }
                return header
            }
        default:
            return UICollectionReusableView()
        }
    }
    
    // MARK: - Init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.setupViews()
            }
        }
    }
        
    // MARK: - Setups
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalToSuperview()
        }
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

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountOfItemsInSection(sectionNumber: section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let recipe = viewModel.getOneOfLastRecipes(itemNumber: indexPath.item)
            return configureRecentRecipeCell(collectionView: collectionView, indexPath: indexPath, recipe: recipe)
        case 1:
            let recipe = viewModel.getOneOfSelectionRecipes(itemNumber: indexPath.item)
            return configureSelectionRecipeCell(collectionView: collectionView, indexPath: indexPath, recipe: recipe)
        case 2, 3, 4:
            let wineSort = viewModel.getWineSort(indexPath: indexPath)
            return configureWineSortCell(collectionView: collectionView, indexPath: indexPath, wineSort: wineSort)
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - configureCell
extension MainViewController {
    private func configureRecentRecipeCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        recipe: Recipe
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentRecipeCell.reuseIdentifier,
            for: indexPath
        ) as? RecentRecipeCell else {
            fatalError("error")
        }
        cell.configureCell(title: recipe.title, imageUrlString: recipe.image)
        return cell
    }
    
    func configureSelectionRecipeCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        recipe: Recipe
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectionRecipeCell.reuseIdentifier,
            for: indexPath
        ) as? SelectionRecipeCell else {
            fatalError("error")
        }
        cell.configureCell(title: recipe.title, imageUrlString: recipe.image)
        return cell
    }
    
    private func configureWineSortCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        wineSort: WineSort
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WineSortCell.reuseIdentifier,
            for: indexPath
        ) as? WineSortCell else {
            fatalError("error")
        }
        cell.configureCell(title: wineSort.title, description: wineSort.description)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
}
