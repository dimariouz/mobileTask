//
//  StorageService.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation
import RealmSwift

protocol StorageServiceProtocol: AnyObject {
    func addToFavotite(user: User)
    func fetchFavorites() -> [User]
}

class StorageService: StorageServiceProtocol {
    
    private let realm = try? Realm()
    
    func addToFavotite(user: User) {
        let favoriteItem = FavoriteUser(user: user)
        
        if let existing = realm?.objects(FavoriteUser.self).where({ $0.id == favoriteItem.id }).first {
            try? realm?.write {
                realm?.delete(existing)
            }
        } else {
            try? realm?.write {
                realm?.add(favoriteItem, update: .all)
            }
        }
    }
    
    func fetchFavorites() -> [User] {
        guard let objects = (realm?.objects(FavoriteUser.self)) else { return [] }
        return Array(objects).map(User.init)
    }
}
