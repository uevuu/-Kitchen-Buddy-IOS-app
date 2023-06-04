//
//  SearchViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import UIKit
import SnapKit

// MARK: - SearchViewController
final class SearchViewController: UIViewController {
    // MARK: - Dependencies
    private var viewModel: SearchViewModel
    
    // MARK: - Properties
    private var tableView: UITableView?
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "AppBackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self

        collectionView.register(
            IngredientCell.self,
            forCellWithReuseIdentifier: IngredientCell.reuseIdentifier
        )
        
        collectionView.register(
            IngredientHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: IngredientHeader.reuseIdentifier
        )
        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 40)
        return layout
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search recipes"
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var filterlButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped)
        )
        button.tintColor = UIColor(named: "SecondFontColor")
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        button.tintColor = UIColor(named: "SecondFontColor")
        return button
    }()

    // MARK: - Init
    init(viewModel: SearchViewModel) {
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
        view.backgroundColor = UIColor(named: "AppBackgroundColor")
        navigationItem.rightBarButtonItem = filterlButton
        navigationItem.titleView = searchBar
        view.addSubview(collectionView)
        searchBar.delegate = self
        setConstraints()
    }
    
    // MARK: - TableView functions
    private func createTableView() {
        tableView = UITableView()
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.backgroundColor = UIColor(named: "AppBackgroundColor")
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView?.register(
            IngredientTableViewCell.self,
            forCellReuseIdentifier: IngredientTableViewCell.reuseIdentifier
        )
        tableView?.register(
            RecipeTableViewCell.self,
            forCellReuseIdentifier: RecipeTableViewCell.reuseIdentifier
        )
        view.addSubview(tableView ?? UITableView())
        tableView?.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func removeTableView() {
        tableView?.removeFromSuperview()
        tableView = nil
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func addIngredientsButtonTapped() {
        searchBar.placeholder = "Search ingredients"
        viewModel.desiredObject = .ingredient
        searchBar.becomeFirstResponder()
    }
    
    @objc private func filterButtonTapped() {
        viewModel.goToFilterModule()
    }

    @objc private func cancelButtonTapped() {
        searchBar.placeholder = "Search recipes"
        searchBar.text = ""
        searchBar.resignFirstResponder()
        removeTableView()
        viewModel.desiredObject = .recipe
        viewModel.cleanFoundObjects()
        navigationItem.rightBarButtonItem = filterlButton
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        createTableView()
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchData(query: searchText) { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountOfFoundData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.desiredObject {
        case .recipe:
            let recipe = viewModel.getFoundRecipes(at: indexPath.row)
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecipeTableViewCell",
                for: indexPath
            ) as? RecipeTableViewCell else {
                fatalError("error")
            }
            cell.configureCell(title: recipe.title, image: recipe.image, nutrition: recipe.nutrition)
            return cell
        case .ingredient:
            let ingredient = viewModel.getFoundIngredient(at: indexPath.row)
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "IngredientTableViewCell",
                for: indexPath
            ) as? IngredientTableViewCell else {
                fatalError("error")
            }
            cell.configureCell(
                title: ingredient.name,
                isAdded: viewModel.isIncludedIngredient(ingredient)
            )
            cell.delegate = self
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.handleTapOnRecipe(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return viewModel.isTapped()
    }
}

extension SearchViewController: UICollectionViewDataSource {
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
            withReuseIdentifier: IngredientCell.reuseIdentifier,
            for: indexPath
        ) as? IngredientCell else {
            fatalError("error")
        }
        let recipe = viewModel.getIncludeIngredient(at: indexPath.row)
        cell.configureCell(
            title: recipe.name
        )
        cell.delegate = self
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: IngredientHeader.reuseIdentifier,
            for: indexPath
        ) as? IngredientHeader else {
            fatalError("error")
        }
        header.configureCell(headerName: "▼ Included ingredients")
        header.setTargetForButton(
            target: self,
            action: #selector(addIngredientsButtonTapped),
            event: .touchUpInside
        )
        return header
    }
}

extension SearchViewController: IngredientCellDelegate {
    func deleteButtonTapped(cell: IngredientCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        viewModel.deleteIncludeIngredient(at: indexPath.row) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension SearchViewController: IngredientTableViewCellDelegate {    
    func addButtonTapped(cell: IngredientTableViewCell) {
        guard let indexPath = tableView?.indexPath(for: cell) else {
            return
        }
        viewModel.addIngedient(at: indexPath.row)
        collectionView.reloadData()
    }
}
