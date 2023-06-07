//
//  IngredientCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.06.2023.
//

import UIKit

protocol IngredientCellDelegate: AnyObject {
    func deleteButtonTapped(cell: IngredientCell)
}

final class IngredientCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecipeCell"
    weak var delegate: IngredientCellDelegate?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.appBackgroundColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("\u{2718}", for: .normal)
        button.setTitleColor(Asset.Colors.appMainFontColor.color, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        contentView.backgroundColor = Asset.Colors.appSectionFontColor.color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(deleteButton)
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.bottom.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.height.equalToSuperview()
            make.width.equalTo(2)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(separatorView.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureCell(title: String) {
        titleLabel.text = title
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.deleteButtonTapped(cell: self)
    }
}
