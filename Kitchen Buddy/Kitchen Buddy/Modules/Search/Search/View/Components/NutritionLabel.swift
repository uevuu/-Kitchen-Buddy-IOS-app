//
//  NutritionLabel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

import UIKit

final class NutritionLabel: UILabel {
    init(nutritionName: String) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text = nutritionName
        textColor = UIColor(named: "SecondFontColor")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
