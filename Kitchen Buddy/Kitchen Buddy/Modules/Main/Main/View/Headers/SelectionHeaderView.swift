//
//  SelectionHeaderView.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 16.05.2023.
//

import UIKit

final class SelectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier: String = "SelectionHeaderViewReuseIdentifier"

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "AppMainFontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Button.all, for: .normal)
        button.setTitleColor(UIColor(named: "AppLinkFontColor"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setConstraint()
    }
    
    func setupView() {
        addSubview(headerLabel)
        addSubview(allButton)
    }
    
    func configureCell(headerName: String) {
        headerLabel.text = headerName
    }
    
    func setConstraint() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        
        allButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func setTargetForButton(target: Any?, action: Selector, event: UIControl.Event) {
        allButton.addTarget(target, action: action, for: event)
    }
}
