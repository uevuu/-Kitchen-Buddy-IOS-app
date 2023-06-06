//
//  SelectionRecipeCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 15.05.2023.
//

import UIKit

final class SelectionRecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "SelectionRecipeCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(named: "RecipeTitleFontColor")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(3)
            make.top.equalTo(recipeImageView.snp.bottom).offset(3)
            make.trailing.equalToSuperview().offset(-3)
        }
        recipeImageView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
    }
    
    func configureCell(title: String, imageUrlString: String? ) {
        titleLabel.text = title
        guard let imageUrlString else {
            recipeImageView.image = UIImage(named: "NoImageAvailable")
            return
        }
        let url = URL(string: imageUrlString)
        recipeImageView.kf.setImage(with: url)
    }
}
