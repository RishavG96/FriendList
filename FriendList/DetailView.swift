//
//  DetailView.swift
//  FriendList
//
//  Created by Rishav Gupta on 22/06/23.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        VStack {
            Form {
                Section("Self Data") {
                    Text("Name: \(user.wrappedName)")
                    
                    Text("Is User Active: \(user.isActive)" as String)
                    
                    Text("Age: \(user.age)")
                    
                    Text("Compang: \(user.wrappedCompany)")
                    
                    Text("Email: \(user.wrappedEmail)")
                    
                    Text("Address: \(user.wrappedAddress)")
                    
                    Text("About: \(user.wrappedAbout)")
                    
                    Text("Date Registered: \(user.wrappedRegistered)")
                }
                
                Section("FriendsList") {
                    ForEach(user.wrappedFriend, id: \.self) { friend in
                        Text(friend.wrappedName)
                    }
                }
            }
        }
        .navigationTitle("User Data")
        .navigationBarTitleDisplayMode(.inline)
    }
}
