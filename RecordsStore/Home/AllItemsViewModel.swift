//
//  AllItemsViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

@MainActor
class AllItemsViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchItems() async {
        isLoading = true
        errorMessage = nil

        do {
            items = try await NetworkService.shared.fetchItems()
        } catch {
            errorMessage = "Error fetching items: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
