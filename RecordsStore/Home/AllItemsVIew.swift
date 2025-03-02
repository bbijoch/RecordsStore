//
//  AllItemsVIew.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct AllItemsView: View {
    @StateObject private var viewModel = AllItemsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                GenreListView()

                List(viewModel.items) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.artist)
                                .font(.subheadline)
                            Text(item.format)
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("All Items")
                .onAppear {
                    Task {
                        await viewModel.fetchItems()
                    }
                }
                .overlay {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }

            }
        }
    }
}
