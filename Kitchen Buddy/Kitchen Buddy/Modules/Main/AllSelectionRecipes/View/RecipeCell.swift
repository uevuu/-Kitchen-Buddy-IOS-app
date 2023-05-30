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
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "AppSectionFontColor")
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(contentView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    func configureCell(recipe: Recipe) {
        titleLabel.text = recipe.title
        guard let imageUrlString = recipe.image else {
            recipeImageView.image = UIImage(named: "NoImageAvailable")
            return
        }
        let url = URL(string: imageUrlString)
        recipeImageView.kf.setImage(with: url)
    }
}
