//
//  MyUserView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct MyUserView: View {
    @ObservedObject var viewModel: MyUserViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    Text("Username: \(user.username)")
                    Text("Email: \(user.email)")
                } else {
                    Text("Loading user info...")
                }
            }
            .padding()
            .navigationTitle("My Profile")
        }
    }
}
