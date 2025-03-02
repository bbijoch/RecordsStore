//
//  GenreListView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct GenreListView: View {
    let genres: [Genre] = [
        Genre(name: "Rock", imageName: "vinyl01"),
        Genre(name: "Jazz", imageName: "vinyl01"),
        Genre(name: "Pop", imageName: "vinyl01"),
        Genre(name: "Hip-Hop", imageName: "vinyl01"),
        Genre(name: "Classical", imageName: "vinyl01"),
        Genre(name: "Blues", imageName: "vinyl01"),
        Genre(name: "Electronic", imageName: "vinyl01"),
        Genre(name: "Country", imageName: "vinyl01"),
        Genre(name: "Reggae", imageName: "vinyl01"),
        Genre(name: "Metal", imageName: "vinyl01")
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(genres) { genre in
                    NavigationLink(destination: FilteredItemsView(genre: genre)) {
                        VStack {
                            Image(genre.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 3)

                            Text(genre.name)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.top, 4)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
    }
}
