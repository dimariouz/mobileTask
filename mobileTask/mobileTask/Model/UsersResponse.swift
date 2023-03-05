//
//  UsersResponse.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation
import RealmSwift

struct UsersResponse: Codable {
    let page: Int?
    let totalPages: Int?
    let users: [User]
}

struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    var isFavorite = false
    
    init(id: Int, email: String, firstName: String, lastName: String, avatar: String, isFavorite: Bool = false) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.isFavorite = isFavorite
    }
    
    init(from db: FavoriteUser) {
        id = db.id
        email = db.email
        firstName = db.firstName
        lastName = db.lastName
        avatar = db.avatar
        isFavorite = true
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    static var mockUser: User {
        User(id: 0, email: "email", firstName: "firstName", lastName: "lastName", avatar: "avatar")
    }
}

class FavoriteUser: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var email = ""
    @Persisted var firstName = ""
    @Persisted var lastName = ""
    @Persisted var avatar = ""
    
    convenience init(user: User) {
        self.init()
        self.id = user.id
        self.email = user.email
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.avatar = user.avatar
    }
}
