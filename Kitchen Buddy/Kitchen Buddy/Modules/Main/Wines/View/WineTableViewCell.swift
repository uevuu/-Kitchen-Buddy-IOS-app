//
//  WineTableViewCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 28.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class WineTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "WineTableViewCell"

    private let wineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SecondFontColor")
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SecondFontColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingLabel, ratingCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
     
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingStackView, priceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var recipeTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wineImageView, recipeTextStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
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
        contentView.backgroundColor = UIColor(named: "AppBackgroundColor")
        contentView.addSubview(mainStackView)
        contentView.addSubview(descriptionLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(120)
        }
        
        wineImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.bottom.lessThanOrEqualToSuperview().inset(15)
        }
    }
    
    func isExpended(_ bool: Bool) {
        descriptionLabel.numberOfLines = bool ? 0 : 1
    }
    
    func configureCell(wine: Wine) {
        titleLabel.text = wine.title
        ratingLabel.text = wine.averageRating.toMarkString()
        ratingCountLabel.text = "\(wine.ratingCount)"
        priceLabel.text = wine.price.toTwoDecimalPlacesString()        
        descriptionLabel.text = wine.description?.isEmpty == false ? wine.description : "There is no description"

        if wine.averageRating < 0.5 {
            ratingLabel.textColor = UIColor(named: "BadRatingFontColor")
        } else if wine.averageRating >= 0.5 && wine.averageRating <= 0.75 {
            ratingLabel.textColor = UIColor(named: "MediumRatingFontColor")
        } else {
            ratingLabel.textColor = UIColor(named: "GoodRatingFontColor")
        }
        
        wineImageView.kf.setImage(with: URL(string: wine.imageUrl))
    }
}
