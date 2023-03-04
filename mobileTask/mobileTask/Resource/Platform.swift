//
//  Platform.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

final class Platform {
    
    let networkService: NetworkServiceProtocol
    let usersService: UsersServiceProtocol
    
    static let shared = Platform()
        
    private init() {
        networkService = NetworkService()
        usersService = UsersService(networkService: networkService)
    }
}
