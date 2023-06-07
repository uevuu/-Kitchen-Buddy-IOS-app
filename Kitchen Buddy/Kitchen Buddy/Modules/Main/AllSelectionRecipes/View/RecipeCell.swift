//
//  RecipeCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import UIKit
import Kingfisher

final class RecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecipeCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(named: "AppMainFontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let totalPriceLabel = RecipeCellInfoLabel()
    private let servingLabel = RecipeCellInfoLabel()
    private let timeLabel = RecipeCellInfoLabel()
    
    private let popularStatusLabel = RecipeStatusLabel(statusName: "popular")
    private let healthyStatusLabel = RecipeStatusLabel(statusName: "healthy")
    private let cheapStatusLabel = RecipeStatusLabel(statusName: "cheap")
    private let veganStatusLabel = RecipeStatusLabel(statusName: "vegan")
    private let vegetarianStatusLabel = RecipeStatusLabel(statusName: "vegetarian")
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalPriceLabel, servingLabel, timeLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var upperStatusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popularStatusLabel, healthyStatusLabel, cheapStatusLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var lowerStatusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [veganStatusLabel, vegetarianStatusLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
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
        contentView.backgroundColor = UIColor(named: "AppSectionFontColor")
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(upperStatusStackView)
        contentView.addSubview(lowerStatusStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().inset(6)
            make.width.equalTo(contentView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(12)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel.snp.leading).offset(3)
        }
        
        upperStatusStackView.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(5)
            make.centerX.equalTo(titleLabel)
        }
        
        lowerStatusStackView.snp.makeConstraints { make in
            make.top.equalTo(upperStatusStackView.snp.bottom).offset(3)
            make.centerX.equalTo(upperStatusStackView)
        }
    }
    
    func configureCell(recipe: Recipe) {
        titleLabel.text = recipe.title
        totalPriceLabel.text = "\(String(format: "%.2f", recipe.pricePerServing * Double(recipe.servings) / 100)) $"
        servingLabel.text = "\(recipe.servings) servings for \(String(format: "%.2f", recipe.pricePerServing / 100)) $"
        timeLabel.text = "\(recipe.readyInMinutes) minutes"
        
        popularStatusLabel.backgroundColor = recipe.veryPopular
            ? UIColor(named: "OrangeStatusColor") : popularStatusLabel.backgroundColor
        healthyStatusLabel.backgroundColor = recipe.veryHealthy
            ? UIColor(named: "GreenStatusColor") : healthyStatusLabel.backgroundColor
        cheapStatusLabel.backgroundColor = recipe.cheap
            ? UIColor(named: "OrangeStatusColor") : cheapStatusLabel.backgroundColor
        veganStatusLabel.backgroundColor = recipe.vegan
            ? UIColor(named: "GreenStatusColor") : veganStatusLabel.backgroundColor
        vegetarianStatusLabel.backgroundColor = recipe.vegetarian
            ? UIColor(named: "GreenStatusColor") : vegetarianStatusLabel.backgroundColor
        
        guard let imageUrlString = recipe.image else {
            recipeImageView.image = Asset.Images.noImageAvailable.image
            return
        }
        let url = URL(string: imageUrlString)
        recipeImageView.kf.setImage(with: url)
    }
}
