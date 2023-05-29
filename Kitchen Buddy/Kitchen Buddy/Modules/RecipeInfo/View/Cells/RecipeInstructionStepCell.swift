//
//  RecipeInstructionStepCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

import UIKit

final class RecipeInstructionStepCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecipeInstructionStepCell"
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(instructionLabel)
        contentView.addSubview(stepNumberLabel)
        contentView.backgroundColor = UIColor(named: "AppSecondBackgroundColor")
        setConstraints()
    }
    
    private func setConstraints() {
        stepNumberLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(stepNumberLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configureCell(step: Step) {
        instructionLabel.text = step.step
        stepNumberLabel.text = "\(step.number) step"
    }
}
