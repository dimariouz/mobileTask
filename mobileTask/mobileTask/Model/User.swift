//
//  User.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
