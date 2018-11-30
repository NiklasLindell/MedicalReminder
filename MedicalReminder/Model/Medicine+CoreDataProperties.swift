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

}
