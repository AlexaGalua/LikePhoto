//
//  Saving+CoreDataProperties.swift
//  SavingimgCoreData
//
//  Created by A on 4/19/22.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var favo: Bool
    @NSManaged public var imageD: Data?
    @NSManaged public var username: String?

}

extension Saving : Identifiable {

}
