//
//  SelectableSettingModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

struct SelectableSettingModel: Codable {
    let name: String
    var isSelected = false
}

extension Collection where Element == SelectableSettingModel {
    func getSelected() -> [String] {
        return self.filter { $0.isSelected }.map { $0.name }
    }
}
