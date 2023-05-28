//
//  Double+Extensions.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 28.05.2023.
//

import Foundation

extension Double {
    func toMarkString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        if let formattedValue = formatter.string(from: NSNumber(value: self * 10)) {
            return formattedValue
        }
        return nil
    }
}
