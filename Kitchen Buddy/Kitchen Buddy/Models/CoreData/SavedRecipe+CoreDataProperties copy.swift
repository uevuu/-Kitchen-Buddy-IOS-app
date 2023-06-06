//
//  SavedRecipe+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 06.06.2023.
//
//

import Foundation
import CoreData

extension SavedRecipe {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<SavedRecipe> {
        return NSFetchRequest<SavedRecipe>(entityName: "SavedRecipe")
    }

    @NSManaged public var cheap: Bool
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var pricePerServing: Double
    @NSManaged public var readyInMinutes: Int64
    @NSManaged public var servings: Int64
    @NSManaged public var title: String?
    @NSManaged public var vegan: Bool
    @NSManaged public var vegetarian: Bool
    @NSManaged public var veryHealthy: Bool
    @NSManaged public var veryPopular: Bool
    @NSManaged public var analyzedInstructions: NSSet?
}

// MARK: Generated accessors for analyzedInstructions
extension SavedRecipe {
    @objc(addAnalyzedInstructionsObject:)
    @NSManaged public func addToAnalyzedInstructions(_ value: SavedAnalyzedInstruction)

    @objc(removeAnalyzedInstructionsObject:)
    @NSManaged public func removeFromAnalyzedInstructions(_ value: SavedAnalyzedInstruction)

    @objc(addAnalyzedInstructions:)
    @NSManaged public func addToAnalyzedInstructions(_ values: NSSet)

    @objc(removeAnalyzedInstructions:)
    @NSManaged public func removeFromAnalyzedInstructions(_ values: NSSet)
}
