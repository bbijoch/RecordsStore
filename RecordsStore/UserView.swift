//
//  ProfileView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var user: User?

    var body: some View {
        NavigationView {
            VStack {
                if let user = user {
                    Text("Username: \(user.username)")
                    Text("Email: \(user.email)")
                } else {
                    Text("Loading user info...")
                }
            }
            .padding()
            .navigationTitle("My Profile")
            .task {
                do {
                    try await viewModel.fetchUsers()
                    user = viewModel.users.first
                } catch {
                    print("Error fetching user info: \(error)")
                }
            }
        }
    }
}
