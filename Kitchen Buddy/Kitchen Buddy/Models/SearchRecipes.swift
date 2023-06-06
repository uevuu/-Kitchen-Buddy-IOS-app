import Foundation

struct SearchRecipes: Codable {
    let results: [SearchRecipe]
    let totalResults: Int
}

struct SearchRecipe: Codable {
    let id: Int
    let title: String
    let image: String?
    let nutrition: Nutrients
}

struct Nutrients: Codable {
    let nutrients: [Nutrient]
}

struct Nutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
}
