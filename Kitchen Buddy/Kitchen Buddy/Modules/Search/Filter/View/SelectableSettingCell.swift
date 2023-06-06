//
//  SelectableSettingCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import UIKit
import SnapKit

class SelectableSettingCell: UITableViewCell {
    static let reuseIdentifier: String = "SelectableSettingCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedSettingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "SecondaryTranslucentFontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "AppSecondBackgroundColor")
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectedSettingsLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        selectedSettingsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureCell(title: String, selectedSettings: [String]) {
        titleLabel.text = title
        selectedSettingsLabel.text = selectedSettings.joined(separator: ", ")
    }
}
