//
//  UsersService.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation
import Alamofire

protocol UsersServiceProtocol: AnyObject {
    func getUsersList(page: Int) async throws -> UsersResponse
}

final class UsersService: UsersServiceProtocol {
    private enum Path {
        case users(Int)
        
        var path: String {
            switch self {
            case .users(let page):
                return "/api/users?page=\(page)"
            }
        }
    }
    
    private let networkService: NetworkServiceProtocol
        
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getUsersList(page: Int) async throws -> UsersResponse {
        let response: APIResponse<[User]> = try await networkService.get(path: Path.users(page).path)
        return UsersResponse(page: response.page, totalPages: response.totalPages, users: response.data)
    }
}
