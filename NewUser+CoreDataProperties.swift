//
//  NewUser+CoreDataProperties.swift
//  All Ones
//
//  Created by Difeng Chen on 12/13/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//
//

import Foundation
import CoreData


extension NewUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewUser> {
        return NSFetchRequest<NewUser>(entityName: "NewUser")
    }

    @NSManaged public var newUser: Bool

}
