//
//  SimilarRecipeCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 29.05.2023.
//

import UIKit

final class SimilarRecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "SimilarRecipeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .blue
    }
    
    private func setConstraints() {
    }
}
