//
//  MyUserViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

protocol MyUserViewModelDelegate: AnyActor {
    func userDidLoggedOut()
}

@MainActor
class MyUserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    weak var delegate: MyUserViewModelDelegate?

    private let networkService = NetworkService.shared

    func updateUser(updatedUser: User) {
        Task {
            do {
                isLoading = true
                errorMessage = nil
                try await networkService.updateUser(user: updatedUser)
                user = updatedUser
            } catch {
                errorMessage = "Failed to update user: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }

    func logout() {
        delegate?.userDidLoggedOut()
    }
}
