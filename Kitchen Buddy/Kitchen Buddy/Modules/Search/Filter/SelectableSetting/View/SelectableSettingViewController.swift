//
//  SelectableSettingViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import UIKit
import SnapKit

class SelectableSettingViewController: UIViewController {
    private var viewModel: SelectableSettingViewModel
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = Asset.Colors.appBackgroundColor.color
        return tableView
    }()
    
    // MARK: - Init
    
    init(viewModel: SelectableSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        setupViews()
    }
    
    // MARK: - Setups
    func setupViews() {
        view.backgroundColor = Asset.Colors.appBackgroundColor.color
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        setConstraints()
    }
    
    func setConstraints() {
    }
    
    private func configureItems() {
        title = viewModel.getTitle()
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    @objc private func backButtonTapped() {
        viewModel.tapOnBackButton()
    }
    
    deinit {
        viewModel.controllerWasDeinit()
    }
}

extension SelectableSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSettingCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = Asset.Colors.appSecondBackgroundColor.color
        let cellData = viewModel.getCellData(at: indexPath.row)
        cell.textLabel?.text = cellData.name
        cell.accessoryType = cellData.isSelected ? .checkmark : .none
        cell.tintColor = UIColor(named: "AppLinkFontColor")
        return cell
    }
}

extension SelectableSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellTapped(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
