//
//  Artist.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 04/03/2025.
//

struct Artist: Codable, Identifiable {
    let artist: String
    let count: Int

    var id: String {
        artist
    }
}
