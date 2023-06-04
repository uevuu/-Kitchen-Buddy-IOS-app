//
//  Bundle+Extensions.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 30.04.2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project")
        }
        
        return loadedData
    }
    
    func decodeToSelectableSettingModel(file: String) -> [SelectableSettingModel] {
        let settingStringArray: [String] = decode(file: file)
        return settingStringArray.map { SelectableSettingModel(name: $0) }
    }
}
