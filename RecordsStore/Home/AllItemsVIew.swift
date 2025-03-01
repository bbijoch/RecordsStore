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

struct ItemDetailView: View {
    let item: Item

    var body: some View {
        VStack {
            Text(item.title)
                .font(.largeTitle)
            Text("Artist: \(item.artist)")
            Text("Format: \(item.format)")
            Text("Genre: \(item.genre)")
            Text("Release Year: \(item.releaseYear)")
            Text("Condition: \(item.condition)")
            AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            Spacer()
        }
        .padding()
    }
}
