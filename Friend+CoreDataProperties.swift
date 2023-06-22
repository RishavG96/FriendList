//
//  Friend+CoreDataProperties.swift
//  FriendList
//
//  Created by Rishav Gupta on 22/06/23.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var user: User?
    
    var wrappedName: String {
        name ?? "Unknwon Name"
    }

}

extension Friend : Identifiable {

}
