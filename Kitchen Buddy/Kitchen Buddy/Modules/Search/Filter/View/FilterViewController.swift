//
//  FilterViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    private var viewModel: FilterViewModel
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = Asset.Colors.appBackgroundColor.color
        tableView.register(
            SelectableSettingCell.self,
            forCellReuseIdentifier: SelectableSettingCell.reuseIdentifier
        )
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["None", "Price", "Popularity", "Time"])
        segmentedControl.backgroundColor = Asset.Colors.appSecondBackgroundColor.color
        return segmentedControl
    }()
    
    // MARK: - Init
    
    init(viewModel: FilterViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Setups
    func setupViews() {
        segmentedControl.selectedSegmentIndex = viewModel.getSortingParam()
        view.backgroundColor = Asset.Colors.appBackgroundColor.color
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        setConstraints()
    }
    
    func setConstraints() {
    }
    
    private func configureItems() {
        title = L10n.Title.filter
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
    
    @objc private func segmentedControlValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        viewModel.handleSortingParamChanged(index: selectedIndex)
    }
    
    deinit {
        viewModel.controllerWasDeinit()
    }
}

extension FilterViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.selectableSettingCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SelectableSettingCell.reuseIdentifier,
            for: indexPath
        ) as? SelectableSettingCell else {
            fatalError("error")
        }
        let setting = viewModel.getCellSetting(at: indexPath.row)
        cell.configureCell(title: setting.title, selectedSettings: setting.selectedData)
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showSelectableSetting(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        headerView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
