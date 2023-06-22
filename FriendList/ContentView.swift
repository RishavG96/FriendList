//
//  ContentView.swift
//  FriendList
//
//  Created by Rishav Gupta on 22/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLodingComplete = false
    @State private var inProgress = false
    @State private var users: Users = Users()
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var fetchedUsers: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            VStack {
                if isLodingComplete {
                    List(fetchedUsers, id: \.self) { user in
                        NavigationLink {
                            DetailView(user: user)
                        } label: {
                            HStack {
                                Text(user.wrappedName)
                                
                                if user.isActive {
                                    HStack {
                                        Circle()
                                            .fill(.green)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Active")
                                    }
                                    .padding(.all, 2)
                                    .overlay {
                                        Capsule()
                                            .stroke(lineWidth: 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                if inProgress {
                    ProgressView()
                } else {
                    if users.count == 0 {
                        Button("Fetch Connections") {
                            inProgress = true
                            Task {
                                await fetchData()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Connections")
        }
    }
    
    func fetchData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(Users.self, from: data)
                users = decoded
                await MainActor.run {
                    for user in users {
                        let userObject = User(context: moc)
                        userObject.id = user.id
                        userObject.isActive = user.isActive
                        userObject.name = user.name
                        userObject.age = Int16(user.age)
                        userObject.company = user.company
                        userObject.email = user.email
                        userObject.address = user.address
                        userObject.about = user.about
                        userObject.registered = user.formattedRegisteredDate
                        var friendSet: [Friend] = []
                        for friend in user.friends {
                            let friendObject = Friend(context: moc)
                            friendObject.id = friend.id
                            friendObject.name = friend.name
                            friendObject.user = userObject
                            friendSet.append(friendObject)
                        }
                        userObject.friend = NSSet(array: friendSet)
                    }
                    try? moc.save()
                }
                isLodingComplete = true
                inProgress = false
            } catch {
                print("Could not decode data \(error)")
                isLodingComplete = true
                inProgress = false
            }
        } catch {
            print("Could not get data \(error)")
            isLodingComplete = true
            inProgress = false
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
