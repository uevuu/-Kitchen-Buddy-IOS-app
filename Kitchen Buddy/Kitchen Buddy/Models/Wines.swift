import Foundation

struct Wines: Codable {
    let recommendedWines: [Wine]
    let totalFound: Int
}

struct Wine: Codable {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
    let price: String
    let ratingCount: Int
    let averageRating: Double
    let score: Double
}
