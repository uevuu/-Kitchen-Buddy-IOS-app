//
//  InformationLabel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 30.05.2023.
//

import UIKit

final class InformationLabel: UILabel {
    init() {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textColor = Asset.Colors.recipeInfoFontColor.color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
