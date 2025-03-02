//
//  FilteredItemsViewModel.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

class FilteredItemsViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchItems(genre: Genre?) async {
        isLoading = true
        errorMessage = nil

        do {
            items = try await NetworkService.shared.fetchItems(genre: genre?.name)
        } catch {
            errorMessage = "Error fetching items: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
