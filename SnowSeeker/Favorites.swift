//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Edwin Przeźwiecki Jr. on 26/02/2023.
//

import Foundation

class Favorites: ObservableObject {
    
    /// The actual resorts the user has favorited:
    private var resorts: Set<String>
    
    /// The key we're using to read.write in UserDefaults:
    private let saveKey = "Favorites"
    
    init() {
        /// Challenge 2:
        /// Load our saved data:
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        /// Still here? Use an empty array:
        resorts = []
    }
    
    /// Returns true if our set contains this resort:
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    /// Adds the resort to our set, updates all views, and saves the change:
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    /// Removes the resort from our set, updates all views, and saves the change:
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    /// Challenge 2:
    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
