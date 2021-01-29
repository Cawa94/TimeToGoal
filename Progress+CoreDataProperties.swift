//
//  Progress+CoreDataProperties.swift
//  
//
//  Created by Yuri Cavallin on 29/1/21.
//
//

import Foundation
import CoreData


extension Progress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progress> {
        return NSFetchRequest<Progress>(entityName: "Progress")
    }

    @NSManaged public var date: Date?
    @NSManaged public var dayId: Int64
    @NSManaged public var hoursOfWork: Double
    @NSManaged public var goal: Goal?

}
