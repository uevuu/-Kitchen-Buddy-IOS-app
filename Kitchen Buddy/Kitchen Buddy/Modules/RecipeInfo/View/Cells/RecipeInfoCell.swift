//
//  RecipeInfoCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

import UIKit

final class RecipeInfoCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecipeInfoCell"
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel = InformationLabel()
    private let readyTimeLabel = InformationLabel()
    private let servingInfoLabel = InformationLabel()
    private let servingPriceLabel = InformationLabel()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            priceLabel,
            readyTimeLabel,
            servingInfoLabel,
            servingPriceLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(infoStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(200)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.bottom.equalTo(contentView).inset(10)
        }
    }
    
    func configureCell(recipe: Recipe) {
        titleLable.text = recipe.title
        servingInfoLabel.text = "Serving - \(recipe.servings)"
        servingPriceLabel.text = "Price per serving - \(String(format: "%.2f", recipe.pricePerServing / 100)) $"
        readyTimeLabel.text = "Ready time - \(recipe.readyInMinutes)"
        guard let imageUrlString = recipe.image else {
            recipeImageView.image = Asset.Images.noImageAvailable.image
            return
        }
        let url = URL(string: imageUrlString)
        recipeImageView.kf.setImage(with: url)
    }
}
