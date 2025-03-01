//
//  UserViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

@MainActor
class MyUserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let userId = "550e8400-e29b-41d4-a716-446655440000"
    private let networkService = NetworkService.shared

    init() {
        fetchUser()
    }

    func fetchUser() {
        Task {
            do {
                isLoading = true
                errorMessage = nil
                user = try await networkService.fetchUser(userId: userId)
            } catch {
                errorMessage = "Failed to load user: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }

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
}
