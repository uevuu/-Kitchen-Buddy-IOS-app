//
//  RecentRecipeCell .swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 15.05.2023.
//

import UIKit
import Kingfisher

final class RecentRecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecentRecipeCell"
    
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
    
    private lazy var grayLayer: UIView = {
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor(named: "SurfaceViewColor")
        return view
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
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.addSubview(recipeImageView)
        contentView.addSubview(grayLayer)
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        recipeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        grayLayer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(title: String, imageUrlString: String? ) {
        titleLabel.text = title
        guard let imageUrlString else {
            recipeImageView.image = Asset.Images.noImageAvailable.image
            return
        }
        let url = URL(string: imageUrlString)
        recipeImageView.kf.setImage(with: url)
    }
}
