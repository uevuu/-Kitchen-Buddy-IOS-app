//
//  HeaderView.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 16.05.2023.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {
    static let reuseIdentifier: String = "HeaderViewReuseIdentifier"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "AppMainFontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    }
    
    func configureCell(headerName: String) {
        headerLabel.text = headerName
    }
    
    func setConstraint() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
    }
}
