//
//  RecipeCellInfoLabel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import UIKit

final class RecipeCellInfoLabel: UILabel {
    init() {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 15, weight: .light)
        textColor = UIColor(named: "RecipeInfoFontColor")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
