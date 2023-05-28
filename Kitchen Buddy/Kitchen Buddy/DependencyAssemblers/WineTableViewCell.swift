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
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "AppBackgroundColor")
        addSubview(wineImageView)
        addSubview(mainStackView)
    }
    
    private func setConstraints() {
        wineImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.leading.equalTo(wineImageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configureCell(
        title: String,
        price: String,
        imageUrlString: String?,
        rating: Double,
        ratingCount: Int
    ) {
        titleLabel.text = title
        ratingLabel.text = rating.toMarkString()
        ratingCountLabel.text = "\(ratingCount)"
        priceLabel.text = price.toTwoDecimalPlacesString()
        
        if rating < 0.5 {
            ratingLabel.textColor = UIColor(named: "BadRatingFontColor")
        } else if rating >= 0.5 && rating <= 0.75 {
            ratingLabel.textColor = UIColor(named: "MediumRatingFontColor")
        } else {
            ratingLabel.textColor = UIColor(named: "GoodRatingFontColor")
        }
        
        guard let imageUrlString = imageUrlString, let url = URL(string: imageUrlString) else {
            wineImageView.image = UIImage(named: "NoImageAvailable")
            return
        }
    
        wineImageView.kf.setImage(with: url)
    }
}
