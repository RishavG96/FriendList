//
//  UserModel.swift
//  FriendList
//
//  Created by Rishav Gupta on 22/06/23.
//

import Foundation

// MARK: - UserModel
struct UserModel: Identifiable, Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company, email, address, about: String
    let registered: String
    let tags: [String]
    let friends: [FriendModel]
    
    var formattedRegistered: String {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: registered)
        return date?.formatted(date: .abbreviated, time: .omitted) ?? "Unknown Date"
    }
    
    var formattedRegisteredDate: Date {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: registered)
        return date ?? Date.now
    }
}

// MARK: - Friend
struct FriendModel: Identifiable, Codable {
    let id, name: String
}

typealias Users = [UserModel]
