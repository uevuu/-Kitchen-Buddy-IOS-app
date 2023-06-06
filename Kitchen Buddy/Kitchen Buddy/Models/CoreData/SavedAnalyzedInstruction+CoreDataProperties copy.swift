//
//  SavedAnalyzedInstruction+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 06.06.2023.
//
//

import Foundation
import CoreData

extension SavedAnalyzedInstruction {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<SavedAnalyzedInstruction> {
        return NSFetchRequest<SavedAnalyzedInstruction>(entityName: "SavedAnalyzedInstruction")
    }

    @NSManaged public var recipe: SavedRecipe?
    @NSManaged public var steps: NSSet?
}

// MARK: Generated accessors for steps
extension SavedAnalyzedInstruction {
    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: SavedStep)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: SavedStep)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)
}
