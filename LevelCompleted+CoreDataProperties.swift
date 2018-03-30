//
//  LevelCompleted+CoreDataProperties.swift
//  All Ones
//
//  Created by Difeng Chen on 12/9/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//
//

import Foundation
import CoreData


extension LevelCompleted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LevelCompleted> {
        return NSFetchRequest<LevelCompleted>(entityName: "LevelCompleted")
    }

    @NSManaged public var levelNum: Int16

}
