//
//  String+Extensions.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 28.05.2023.
//

import Foundation

extension String {
    func toTwoDecimalPlacesString() -> String? {
        let priceValueString = self.replacingOccurrences(of: "$", with: "")
        if let priceValue = Double(priceValueString) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            if let formattedPrice = formatter.string(from: NSNumber(value: priceValue)) {
                return formattedPrice
            }
        }
        return nil
    }
}
