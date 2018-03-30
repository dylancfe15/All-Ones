//
//  Coins+CoreDataProperties.swift
//  All Ones
//
//  Created by Difeng Chen on 12/13/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//
//

import Foundation
import CoreData


extension Coins {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coins> {
        return NSFetchRequest<Coins>(entityName: "Coins")
    }

    @NSManaged public var amount: Int16

}
