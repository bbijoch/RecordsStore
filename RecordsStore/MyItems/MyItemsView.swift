//
//  MyItemsView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct MyItemsView: View {
    @ObservedObject var viewModel: MyItemsViewModel
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    VStack(alignment: .leading) {
                        Text(item.title).font(.headline)
                        Text(item.artist).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("My Items")
            .onAppear {
                Task {
                    await viewModel.fetchMyItems(userId: userViewModel.user.id)
                }
            }
        }
    }
}
