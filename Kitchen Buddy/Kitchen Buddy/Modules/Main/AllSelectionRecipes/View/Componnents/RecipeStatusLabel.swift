//
//  RecipeStatusLabel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 31.05.2023.
//

import UIKit

final class RecipeStatusLabel: UILabel {
    init(statusName: String) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 15, weight: .light)
        text = " \(statusName) "
        textColor = UIColor(named: "RecipeInfoFontColor")
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = Asset.Colors.appBackgroundColor.color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
