//
//  ItemViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

@MainActor
class MyItemsViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var user: User?

    func fetchMyItems() async {
        guard let user = user else {
            errorMessage = "User not logged in"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            items = try await NetworkService.shared.fetchMyItems(sellerId: user.id.uuidString)
        } catch {
            errorMessage = "Error fetching items: \(error)"
        }

        isLoading = false
    }

    func updateItem(item: Item) async throws {
        try await NetworkService.shared.updateItem(item: item)
    }
}
