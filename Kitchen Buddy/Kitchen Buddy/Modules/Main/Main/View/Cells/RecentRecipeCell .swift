//
//  RecentRecipeCell .swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 15.05.2023.
//

import UIKit

final class RecentRecipeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "RecentRecipeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
