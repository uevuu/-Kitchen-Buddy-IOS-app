//
//  SavedStep+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 06.06.2023.
//
//

import Foundation
import CoreData

extension SavedStep {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<SavedStep> {
        return NSFetchRequest<SavedStep>(entityName: "SavedStep")
    }

    @NSManaged public var number: Int64
    @NSManaged public var step: String?
    @NSManaged public var ingredients: NSSet?
}

// MARK: Generated accessors for ingredients
extension SavedStep {
    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: SavedIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: SavedIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)
}
