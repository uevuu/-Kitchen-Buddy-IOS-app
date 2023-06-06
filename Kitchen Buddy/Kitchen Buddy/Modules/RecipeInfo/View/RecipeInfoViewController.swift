//
//  RecipeInfoViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import UIKit

class RecipeInfoViewController: UIViewController {
    // MARK: - Dependencies
    private var viewModel: RecipeInfoViewModel
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "AppBackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            RecipeInfoCell.self,
            forCellWithReuseIdentifier: RecipeInfoCell.reuseIdentifier
        )
        collectionView.register(
            RecipeInstructionStepCell.self,
            forCellWithReuseIdentifier: RecipeInstructionStepCell.reuseIdentifier
        )
        collectionView.register(
            SelectionRecipeCell.self,
            forCellWithReuseIdentifier: SelectionRecipeCell.reuseIdentifier
        )
        
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.reuseIdentifier
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
    init(viewModel: RecipeInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBackgroundColor")
        configureItems()
        setupViews()
        title = viewModel.getRecipeTitle()
        viewModel.viewDidLoadEvent { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadSections(IndexSet(integer: 2))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem?.image = viewModel.setImage()
    }
    
    deinit {
        viewModel.controllerWasDeinit()
    }
    
    // MARK: - Setups
    private func setupViews() {
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(starButtonTapped)
        )
    }
    
    // MARK: - Private
    @objc private func backButtonTapped() {
        viewModel.tapOnBackButton()
    }
    
    @objc private func starButtonTapped() {
        viewModel.tapOnStarButton()
        navigationItem.rightBarButtonItem?.image = viewModel.setImage()
    }
}

extension RecipeInfoViewController: UICollectionViewDataSource {
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
        switch indexPath.section {
        case 0:
            return configureRecipeInfoCell(collectionView: collectionView, indexPath: indexPath)
        case 1:
            return configureRecipeInstructionStepCell(collectionView: collectionView, indexPath: indexPath)
        case 2:
            return configureSimilarRecipeCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
}

extension RecipeInfoViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath
        ) as? HeaderView else {
            fatalError("error")
        }
        header.configureCell(headerName: "Similar recipes")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            viewModel.selectSimilarRecipe(recipeNumber: indexPath.item)
        }
    }
}

// MARK: - configureCell
extension RecipeInfoViewController {
    private func configureRecipeInfoCell(
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeInfoCell.reuseIdentifier,
            for: indexPath
        ) as? RecipeInfoCell else {
            fatalError("error")
        }
        let recipe = viewModel.getRecipe()
        cell.configureCell(recipe: recipe)
        return cell
    }
    
    private func configureRecipeInstructionStepCell(
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeInstructionStepCell.reuseIdentifier,
            for: indexPath
        ) as? RecipeInstructionStepCell else {
            fatalError("error")
        }
        if let step = viewModel.getStep(stepNumber: indexPath.item) {
            cell.configureCell(step: step)
        }
        return cell
    }
    
    private func configureSimilarRecipeCell(
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectionRecipeCell.reuseIdentifier,
            for: indexPath
        ) as? SelectionRecipeCell else {
            fatalError("error")
        }
        if let recipe = viewModel.getSimilarRecipe(recipeNumber: indexPath.item) {
            cell.configureCell(title: recipe.title, imageUrlString: recipe.image)
        }
        return cell
    }
}
