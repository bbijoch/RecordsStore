//
//  RootView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()

    var body: some View {
        TabView {
            AllItemsView()
                .tabItem {
                    Label("Home", systemImage: "music.note.house")
                }

            MyItemsView(viewModel: viewModel.myItemsViewModel)
                .tabItem {
                    Label("My Items", systemImage: "tray.full")
                }

            MyUserView(viewModel: viewModel.myUserViewModel)
                .tabItem {
                    Label("My User", systemImage: "person.fill")
                }
        }
        .sheet(isPresented: .constant(!viewModel.isLoggedIn)) {
            LoginView(viewModel: viewModel.loginViewModel)
                .onDisappear {
                    // Check the login state after the modal is dismissed
                    viewModel.checkLogin()
                }
        }
        .onAppear {
            // Check if the user is logged in and update the state
            viewModel.checkLogin()
        }
    }
}
