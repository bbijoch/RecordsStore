//
//  User.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var username: String
    var email: String
    var password: String? // Optional for updates
}
