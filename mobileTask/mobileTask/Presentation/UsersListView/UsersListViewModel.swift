//
//  UsersListViewModel.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

final class UsersListViewModel {
    private let platform: Platform
    
    private var usersResponse: UsersResponse?
    
    private(set) var usersList: [User] = []
    
    var currentPage: Int {
        usersResponse?.page ?? 1
    }
    
    var totalPages: Int {
        usersResponse?.totalPages ?? 0
    }
    
    var didReceiveError: Closure<Error>?
    var didReceiveResult: Closure<Void>?
    var isLoading: Closure<Bool>?
    
    init(platform: Platform) {
        self.platform = platform
    }
    
    func fetchUsers(page: Int = 1) {
        isLoading?(true)
        Task {
            do {
                usersResponse = try await platform.usersService.getUsersList(page: page)
                usersList += (usersResponse?.users ?? [])
                DispatchQueue.main.async {
                    self.didReceiveResult?(())
                    self.isLoading?(false)
                }
            } catch {
                DispatchQueue.main.async {
                    self.didReceiveError?(error)
                    self.isLoading?(false)
                }
            }
        }
    }
    
    func refreshFetch() {
        usersList = []
        fetchUsers(page: 1)
    }
}
