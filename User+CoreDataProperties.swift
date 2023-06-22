//
//  User+CoreDataProperties.swift
//  FriendList
//
//  Created by Rishav Gupta on 22/06/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var id: String?
    @NSManaged public var friend: NSSet?

    var wrappedId: String {
        id ?? "Unknown Id"
    }

    var wrappedName: String {
        name ?? "Unknown Name"
    }

    var wrappedCompany: String {
        company ?? "Unknown Company"
    }

    var wrappedEmail: String {
        email ?? "Unknwon Email"
    }

    var wrappedAddress: String {
        address ?? "Unknown Address"
    }

    var wrappedAbout: String {
        about ?? "Wrapped About"
    }

    var wrappedRegistered: Date {
        registered ?? Date.now
    }

    var wrappedFriend: [Friend] {
        let friends = friend as? Set<Friend> ?? []
        
        return friends.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for friend
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: Friend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: Friend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension User : Identifiable {

}
