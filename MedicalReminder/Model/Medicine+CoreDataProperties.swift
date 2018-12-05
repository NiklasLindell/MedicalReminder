//
//  Medicine+CoreDataProperties.swift
//  MedicalReminder
//
//  Created by Niklas Lindell on 2018-11-30.
//  Copyright © 2018 Niklas Lindell. All rights reserved.
//
//

import Foundation
import CoreData


extension Medicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicine> {
        return NSFetchRequest<Medicine>(entityName: "Medicine")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var totalQuantity: Int16
    @NSManaged public var monday: Bool
    @NSManaged public var tuesday: Bool
    @NSManaged public var wednesday: Bool
    @NSManaged public var thursday: Bool
    @NSManaged public var friday: Bool
    @NSManaged public var saturday: Bool
    @NSManaged public var sunday: Bool
    @NSManaged public var time: [Date]

}
