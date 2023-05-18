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
    private lazy var sections: [Section] = [
        RecentRecipeSection(),
        SelectionRecipeSection(),
        WineSortSection(type: .whiteWines),
        WineSortSection(type: .redWines),
        WineSortSection(type: .otherWines)
    ]
    
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
        var sections = self.sections
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
        setupViews()
    }
        
    // MARK: - Setups
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
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
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].getItemCount()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
}
