//
//  Zdata+CoreDataProperties.swift
//  demoapp002
//
//  Created by zephyr yang on 2019-05-29.
//  Copyright © 2019 zephyr yang. All rights reserved.
//
//

import Foundation
import CoreData


extension Zdata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Zdata> {
        return NSFetchRequest<Zdata>(entityName: "Zdata")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var retired: Bool
    @NSManaged public var income: NSDecimalNumber?

}
