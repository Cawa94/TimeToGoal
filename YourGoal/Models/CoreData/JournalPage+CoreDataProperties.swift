//
//  JournalPage+CoreDataProperties.swift
//  
//
//  Created by Yuri Cavallin on 5/12/20.
//
//

import Foundation
import CoreData


extension JournalPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalPage> {
        return NSFetchRequest<JournalPage>(entityName: "JournalPage")
    }

    @NSManaged public var dayId: Int64
    @NSManaged public var mood: String?
    @NSManaged public var notes: String?
    @NSManaged public var goal: Goal?

}
