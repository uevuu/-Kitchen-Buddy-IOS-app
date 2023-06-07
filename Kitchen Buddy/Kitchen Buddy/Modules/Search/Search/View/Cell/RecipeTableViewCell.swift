//
//  RecipeTableViewCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "RecipeTableViewCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = Asset.Colors.appMainFontColor.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fatInfoLabel = NutritionLabel(nutritionName: "Fat: ?")
    private let caloriesInfoLabel = NutritionLabel(nutritionName: "Calories: ?")
    private let carbohydratesInfoLabel = NutritionLabel(nutritionName: "Carbohydrates ?")
    private let proteinInfoLabel = NutritionLabel(nutritionName: "Protein: ?")
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            caloriesInfoLabel,
            fatInfoLabel,
            carbohydratesInfoLabel,
            proteinInfoLabel
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = Asset.Colors.searchCellBackgroundColor.color
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.height.equalTo(130)
            make.width.equalTo(130)
            make.bottom.lessThanOrEqualToSuperview().inset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(12)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(recipeImageView.snp.trailing).offset(15)
        }
    }
    
    func configureCell(title: String, image: String?, nutrition: Nutrients) {
        titleLabel.text = title
        
        if let fat = nutrition.nutrients.first(where: { $0.name == "Fat" }) {
            let amountString = String(format: "%.2f", fat.amount)
            fatInfoLabel.text = "Fat: \(amountString) \(fat.unit)"
        }
        if let protein = nutrition.nutrients.first(where: { $0.name == "Protein" }) {
            let amountString = String(format: "%.2f", protein.amount)
            proteinInfoLabel.text = "Protein: \(amountString) \(protein.unit)"
        }
        if let carbohydrates = nutrition.nutrients.first(where: { $0.name == "Carbohydrates" }) {
            let amountString = String(format: "%.2f", carbohydrates.amount)
            carbohydratesInfoLabel.text = "Carbohydrates: \(amountString) \(carbohydrates.unit)"
        }
        if let calories = nutrition.nutrients.first(where: { $0.name == "Calories" }) {
            let amountString = String(format: "%.2f", calories.amount)
            caloriesInfoLabel.text = "Calories: \(amountString) \(calories.unit)"
        }
    
        guard let imageUrlString = image else {
            recipeImageView.image = Asset.Images.noImageAvailable.image
            return
        }
        let url = URL(string: imageUrlString)
        recipeImageView.kf.setImage(with: url)
    }
}
