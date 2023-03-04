//
//  UsersListViewModel.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

final class UsersListViewModel: ViewModelHandleProtocol {
    private let platform: Platform
    
    private(set) var usersList: [User] = []
    
    var didReceiveError: Closure<Error>?
    var didReceiveResult: Closure<Void>?
    var isLoading: Closure<Bool>?
    
    init(platform: Platform) {
        self.platform = platform
    }
    
    func fetchUsers() {
        Task {
            do {
                usersList = try await platform.usersService.getUsersList(page: 1)
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
}
