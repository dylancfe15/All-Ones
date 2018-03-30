//
//  RewardLevel+CoreDataProperties.swift
//  
//
//  Created by Difeng Chen on 12/21/17.
//
//

import Foundation
import CoreData


extension RewardLevel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RewardLevel> {
        return NSFetchRequest<RewardLevel>(entityName: "RewardLevel")
    }

    @NSManaged public var rewardLevel: Int16

}
