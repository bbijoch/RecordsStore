//
//  Genre.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import Foundation

struct Genre: Identifiable {
    let name: String
    let imageName: String

    var id: UUID {
        UUID(uuidString: name) ?? UUID()
    }
}
