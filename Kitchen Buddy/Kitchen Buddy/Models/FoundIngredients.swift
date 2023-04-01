import Foundation

struct FoundIngredients: Codable {
    let results: [Ingredient]
    let totalResults: Int
}

struct Ingredient: Codable {
    let id: Int
    let name: String
    let image: String
}
