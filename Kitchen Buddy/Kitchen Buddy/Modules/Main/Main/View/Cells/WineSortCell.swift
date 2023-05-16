//
//  WineSortCell.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 15.05.2023.
//

import UIKit

final class WineSortCell: UICollectionViewCell {
    static let reuseIdentifier: String = "WineSortCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
