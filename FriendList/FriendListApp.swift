//
//  FriendListApp.swift
//  FriendList
//
//  Created by Rishav Gupta on 22/06/23.
//

import SwiftUI

@main
struct FriendListApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
