//
//  RootViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

@MainActor
class RootViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var loginViewModel = LoginViewModel()
    var myItemsViewModel = MyItemsViewModel()
    var myUserViewModel = MyUserViewModel()

    init() {
        loginViewModel.delegate = self
        myUserViewModel.delegate = self
        checkLogin()
    }

    func checkLogin() {
        // Check if the user is logged in by checking the user property in loginViewModel
        isLoggedIn = loginViewModel.user != nil

        if isLoggedIn {
            // Initialize other view models when the user is logged in
            if let user = loginViewModel.user {
                myItemsViewModel.user = user
                myUserViewModel.user = user
            }
        } else {
            // Reset the view models if the user is not logged in
            myItemsViewModel.user = nil
            myUserViewModel.user = nil
        }
    }

    private func logout() {
        loginViewModel.logout()
    }
}

extension RootViewModel: LoginViewModelDelegate {

    func userLoginStatusChanged(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
        checkLogin()
    }
}

extension RootViewModel: MyUserViewModelDelegate {

    func userDidLoggedOut() {
        logout()
    }
}
