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
    let storageService: StorageServiceProtocol
    
    static let shared = Platform()
        
    private init() {
        networkService = NetworkService()
        storageService = StorageService()
        usersService = UsersService(networkService: networkService)
    }
}
