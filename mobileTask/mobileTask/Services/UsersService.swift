//
//  UsersService.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation
import Alamofire

protocol UsersServiceProtocol: AnyObject {
    func getUsersList(page: Int) async throws -> [User]
    func getSingleUser(with id: Int) async throws -> User
}

final class UsersService: UsersServiceProtocol {
    private enum Path {
        case users(Int)
        case user(Int)
        
        var path: String {
            switch self {
            case .users(let page):
                return "/api/users?page=\(page)"
            case .user(let id):
                return "/api/user/\(id)"
            }
        }
    }
    
    private let networkService: NetworkServiceProtocol
        
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getUsersList(page: Int) async throws -> [User] {
        let response: APIResponse<[User]> = try await networkService.get(path: Path.users(page).path)
        return response.data
    }
    
    func getSingleUser(with id: Int) async throws -> User {
        let response: APIResponse<User> = try await networkService.get(path: Path.user(id).path)
        return response.data
    }
}
