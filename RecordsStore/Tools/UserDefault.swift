//
//  UserDefault.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    
    private var value: T {
        get {
            if let data = UserDefaults.standard.data(forKey: key) {
                let decoder = JSONDecoder()
                return (try? decoder.decode(T.self, from: data)) ?? defaultValue
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
    
    var wrappedValue: T {
        get { value }
        set { value = newValue }
    }
}
