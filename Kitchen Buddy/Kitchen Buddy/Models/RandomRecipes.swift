struct RandomRecipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let vegetarian: Bool
    let vegan: Bool
    let veryPopular: Bool
    let cheap: Bool
    let veryHealthy: Bool
    let pricePerServing: Double
    let servings: Int
    let readyInMinutes: Int
    let image: String?
    let title: String
    let summary: String
    let analyzedInstructions: [AnalyzedInstruction]
    let id: Int
}

struct AnalyzedInstruction: Codable {
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
}
