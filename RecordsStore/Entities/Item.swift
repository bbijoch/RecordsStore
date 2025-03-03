//
//  Item.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import Foundation

struct Item: Codable, Identifiable {
    let id: UUID
    var title: String
    var artist: String
    var format: String
    var genre: String
    var releaseYear: Int
    var condition: String
    var coverUrl: String
    var seller: User
    var buyer: User?
    var price: String
    var status: String
    var createdAt: Date
    var soldAt: Date?
}
