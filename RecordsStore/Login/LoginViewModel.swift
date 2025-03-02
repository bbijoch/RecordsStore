//
//  LoginViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

protocol LoginViewModelDelegate: AnyObject {
    func userLoginStatusChanged(isLoggedIn: Bool)
}

@MainActor
class LoginViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var user: User?
    weak var delegate: LoginViewModelDelegate?

    // This property will hold the user that is currently logged in
    @UserDefault(key: "user", defaultValue: nil) private var storedUser: User? {
        didSet {
            // Update the published user when storedUser is set
            if let user = storedUser {
                self.user = user
            } else {
                self.user = nil
            }
        }
    }


    init() {
        // Assign the value from UserDefaults to the published user property
        self.user = storedUser
    }

    func login() async {
        do {

            // Call the network service to fetch the user with login and password
            let fetchedUser = try await NetworkService.shared.login(username: username, password: password)

            // If user is found, update the storedUser property
            if let fetchedUser = fetchedUser {
                self.storedUser = fetchedUser // This will also update `user`
                errorMessage = ""
                delegate?.userLoginStatusChanged(isLoggedIn: true)
            } else {
                errorMessage = "Invalid username or password"
                delegate?.userLoginStatusChanged(isLoggedIn: false)
            }
        } catch {
            errorMessage = "Error logging in: \(error.localizedDescription)"
        }
    }
}
