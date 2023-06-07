//
//  IngredientTableViewCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.06.2023.
//

import UIKit

protocol IngredientTableViewCellDelegate: AnyObject {
    func addButtonTapped(cell: IngredientTableViewCell)
}

final class IngredientTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "IngredientTableViewCell"
    weak var delegate: IngredientTableViewCellDelegate?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "AppMainFontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Button.add, for: .normal)
        button.setTitleColor(UIColor(named: "RecipeInfoFontColor"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        contentView.backgroundColor = UIColor(named: "SearchCellBackgroundColor")
        contentView.addSubview(titleLabel)
        contentView.addSubview(addButton)
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(addButton).inset(10)
            make.height.equalTo(60)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    func configureCell(title: String, isAdded: Bool) {
        if isAdded {
            addButton.setTitle("Added", for: .normal)
        }
        titleLabel.text = title
    }
    
    @objc private func addButtonTapped() {
        delegate?.addButtonTapped(cell: self)
        addButton.setTitle("Added", for: .normal)
    }
}
