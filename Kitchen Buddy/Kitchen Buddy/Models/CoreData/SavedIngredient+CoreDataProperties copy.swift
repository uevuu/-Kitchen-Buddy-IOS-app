//
//  SavedIngredient+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 06.06.2023.
//
//

import Foundation
import CoreData

extension SavedIngredient {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<SavedIngredient> {
        return NSFetchRequest<SavedIngredient>(entityName: "SavedIngredient")
    }

    @NSManaged public var amout: Double
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var unit: String?
    @NSManaged public var step: SavedStep?
}
