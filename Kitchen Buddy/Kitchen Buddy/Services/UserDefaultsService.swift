//
//  UserDefaultsService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 19.05.2023.
//

import Foundation

// MARK: - UserDefaultsService
final class UserDefaultsService {
    private let userDefaults = UserDefaults.standard
    
    
    func saveLastRecipes(recipes: [Recipe]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(recipes), forKey:"MostRecentlyViewedRecipes")
    }
    
    func getLastRecipes() -> [Recipe]? {
        guard let data = UserDefaults.standard.value(forKey:"MostRecentlyViewedRecipes") as? Data else {
            return nil
        }
        let recipes = try? PropertyListDecoder().decode([Recipe].self, from: data)
        return recipes
    }
    
    func save<T>(value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getValue<T>(forKey key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
    func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
