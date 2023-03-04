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
                    self.setupFavorites(usersList: &self.usersList)
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
    
    private func setupFavorites(usersList: inout [User]){
        let favorites = platform.storageService.fetchFavorites()
        usersList = usersList.map { user in
            var _user = user
            if favorites.contains(where: { $0 == _user }) {
                _user.isFavorite = true
            }
            return _user
        }
    }
    
    func refreshFetch() {
        usersList = []
        fetchUsers(page: 1)
    }
    
    func addToFavorite(user: User) {
        guard let index = usersList.firstIndex(where: { $0.id == user.id }) else { return }
        usersList[index].isFavorite.toggle()
        platform.storageService.addToFavotite(user: user)
    }
}
