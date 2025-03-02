//
//  ItemDetailView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.largeTitle)
            Text("Artist: \(item.artist)")
                .bold()
            Text("Format: \(item.format)")
            Text("Genre: \(item.genre)")
            Text("Release Year: \(item.releaseYear)")
            Text("Condition: \(item.condition)")
            Text("Seller: \(item.seller.username)")
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
