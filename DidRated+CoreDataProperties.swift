//
//  DidRated+CoreDataProperties.swift
//  All Ones
//
//  Created by Difeng Chen on 12/13/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//
//

import Foundation
import CoreData


extension DidRated {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DidRated> {
        return NSFetchRequest<DidRated>(entityName: "DidRated")
    }

    @NSManaged public var rated: Bool

}
