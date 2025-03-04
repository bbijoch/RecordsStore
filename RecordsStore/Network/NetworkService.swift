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
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    private init() {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // Set the custom date decoding strategy
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = isoFormatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
            }
        }

        encoder.dateEncodingStrategy = .iso8601
    }

    func login(username: String, password: String) async throws -> User? {
        let url = URL(string: "\(baseURL)/users?username=\(username)&password=\(password)")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let user = try decoder.decode(User.self, from: data)
        return user
    }

    func fetchUsers() async throws -> [User] {
        let url = URL(string: "\(baseURL)/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode([User].self, from: data)
    }

    func fetchUser(userId: String) async throws -> User {
        let url = URL(string: "\(baseURL)/users/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(User.self, from: data)
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

    // Fetch All Items with Query Parameters
    func fetchItems(sellerId: String? = nil,
                    search: String? = nil,
                    buyerId: String? = nil,
                    title: String? = nil,
                    artist: String? = nil,
                    format: String? = nil,
                    genre: String? = nil,
                    releaseYear: Int? = nil,
                    condition: String? = nil) async throws -> [Item] {
        var urlComponents = URLComponents(string: "\(baseURL)/items")!
        var queryItems: [URLQueryItem] = []

        if let sellerId = sellerId { queryItems.append(URLQueryItem(name: "seller_id", value: sellerId)) }
        if let search = search { queryItems.append(URLQueryItem(name: "search", value: search)) }
        if let buyerId = buyerId { queryItems.append(URLQueryItem(name: "buyer_id", value: buyerId)) }
        if let title = title { queryItems.append(URLQueryItem(name: "title", value: title)) }
        if let artist = artist { queryItems.append(URLQueryItem(name: "artist", value: artist)) }
        if let format = format { queryItems.append(URLQueryItem(name: "format", value: format)) }
        if let genre = genre { queryItems.append(URLQueryItem(name: "genre", value: genre)) }
        if let releaseYear = releaseYear { queryItems.append(URLQueryItem(name: "release_year", value: "\(releaseYear)")) }
        if let condition = condition { queryItems.append(URLQueryItem(name: "condition", value: condition)) }

        urlComponents.queryItems = queryItems

        let url = urlComponents.url!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode([Item].self, from: data)
    }

    // ✅ Fetch Items for a Specific Seller
    func fetchMyItems(sellerId: String) async throws -> [Item] {
        return try await fetchItems(sellerId: sellerId)
    }

    // ✅ Create a New Item
    func createItem(item: Item) async throws {
        let url = URL(string: "\(baseURL)/items")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(item)

        let (_, response) = try await URLSession.shared.data(for: request)
        if (response as? HTTPURLResponse)?.statusCode != 201 {
            throw URLError(.badServerResponse)
        }
    }

    // ✅ Update an Existing Item
    func updateItem(item: Item) async throws {
        let url = URL(string: "\(baseURL)/items/\(item.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(item)

        let (_, response) = try await URLSession.shared.data(for: request)
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
    }

    func fetchArtists() async throws -> [Artist] {
        let url = URL(string: "\(baseURL)/artists")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode([Artist].self, from: data)
    }
}
