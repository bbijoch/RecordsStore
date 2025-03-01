//
//  NetworkService.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import Foundation

struct NetworkService {
    static let shared = NetworkService()
    private let baseURL = "http://192.168.1.100:3001/api"

    func fetchUsers() async throws -> [User] {
        let url = URL(string: "\(baseURL)/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }

    func updateUser(user: User) async throws {
        let url = URL(string: "\(baseURL)/users/\(user.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user)

        let (_, response) = try await URLSession.shared.upload(for: request, from: Data())
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
    }

    func fetchItems() async throws -> [Item] {
        let url = URL(string: "\(baseURL)/items")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Item].self, from: data)
    }

    func updateItem(item: Item) async throws {
        let url = URL(string: "\(baseURL)/items/\(item.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(item)

        let (_, response) = try await URLSession.shared.upload(for: request, from: Data())
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
    }

    func fetchOffers() async throws -> [Offer] {
        let url = URL(string: "\(baseURL)/offers")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Offer].self, from: data)
    }

    func updateOffer(offer: Offer) async throws {
        let url = URL(string: "\(baseURL)/offers/\(offer.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(offer)

        let (_, response) = try await URLSession.shared.upload(for: request, from: Data())
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
    }
}
