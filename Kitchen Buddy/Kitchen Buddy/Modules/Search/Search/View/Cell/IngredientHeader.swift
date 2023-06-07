//
//  IngredientHeader.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.06.2023.
//

import UIKit

final class IngredientHeader: UICollectionReusableView {
    static let reuseIdentifier: String = "IngredientHeader"

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = Asset.Colors.secondFontColor.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Button.add, for: .normal)
        button.setTitleColor(Asset.Colors.appLinkFontColor.color, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, addButton])
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubview(stackView)
        setConstraints()
    }
    
    func configureCell(headerName: String) {
        headerLabel.text = headerName
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.top.equalToSuperview()
        }
    }
    
    func setTargetForButton(target: Any?, action: Selector, event: UIControl.Event) {
        addButton.addTarget(target, action: action, for: event)
    }
}
