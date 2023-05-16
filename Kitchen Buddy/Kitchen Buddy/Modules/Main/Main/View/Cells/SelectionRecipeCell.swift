//
//  SelectionRecipeCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 15.05.2023.
//

import UIKit

final class SelectionRecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "SelectionRecipeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
