//
//  MainViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 17.04.2023.
//

import UIKit
import SnapKit

// MARK: - MainViewController
final class MainViewController: UIViewController {
    // MARK: - Dependencies
    private var viewModel: MainViewModel
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = Asset.Colors.appBackgroundColor.color
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
        setupViews()
        viewModel.viewDidLoadEvent { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadSections(IndexSet(integer: 1))
                // сделать кнопку кликабельной
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadLastRecipes { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    // MARK: - Setups
    private func setupViews() {
        view.backgroundColor = Asset.Colors.appBackgroundColor.color
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
     
    // MARK: - Private
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
    
    private func configureSelectionRecipeCell(
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleDidSelectItemAt(indexPath: indexPath)
    }
    
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
                header.configureCell(headerName: L10n.Main.selectionRecipeSection)
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
                    header.configureCell(headerName: L10n.Main.lastRecipeSection)
                } else if indexPath.section == 2 {
                    header.configureCell(headerName: L10n.Main.whiteWineSection)
                } else if indexPath.section == 3 {
                    header.configureCell(headerName: L10n.Main.redWineSection)
                } else if indexPath.section == 4 {
                    header.configureCell(headerName: L10n.Main.otherWineSection)
                }
                return header
            }
        default:
            return UICollectionReusableView()
        }
    }
}
