//
//  FilteredItemsView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct FilteredItemsView: View {
    @StateObject private var viewModel = FilteredItemsViewModel()
    var genre: Genre?

    var body: some View {
        VStack {
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
            .navigationTitle("\(genre?.name ?? "")")
            .onAppear {
                Task {
                    await viewModel.fetchItems(genre: genre)
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
