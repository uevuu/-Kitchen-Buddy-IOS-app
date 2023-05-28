//
//  WinesViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import UIKit

final class WinesViewController: UIViewController {
    private var viewModel: WinesViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WineTableViewCell.self, forCellReuseIdentifier: "WineTableViewCell")
        return tableView
    }()
    
    init(viewModel: WinesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureItems()
        title = viewModel.getWineSortTitle()
        viewModel.viewDidLoadEvent { [weak self] in
            DispatchQueue.main.async {
                self?.updateTableView()
            }
        }
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(named: "AppBackgroundColor")
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
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
    
    private func updateTableView() {
        tableView.reloadData()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        viewModel.tapOnBackButton()
    }
    
    deinit {
        viewModel.controllerWasDeinit()
    }
}

// MARK: - WinesViewController UITableViewDataSource
extension WinesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getWinesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wine = viewModel.getWine(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "WineTableViewCell",
            for: indexPath
        ) as? WineTableViewCell else {
            fatalError("error")
        }
        cell.configureCell(
            title: wine.title,
            price: wine.price,
            imageUrlString: wine.imageUrl,
            rating: wine.averageRating,
            ratingCount: wine.ratingCount
        )
        return cell
    }
}

// MARK: - WinesViewController UITableViewDelegate
extension WinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.handleDidSelectItemAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
