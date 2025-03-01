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

    func fetchMyItems(userId: String) async {
        do {
            let url = URL(string: "\(baseURL)/items?userId=\(userId)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedItems = try JSONDecoder().decode([Item].self, from: data)
            self.items = decodedItems
        } catch {
            print("Error fetching items: \(error)")
        }
    }

    func updateItem(item: Item) async throws {
        try await NetworkService.shared.updateItem(item: item)
    }
}
