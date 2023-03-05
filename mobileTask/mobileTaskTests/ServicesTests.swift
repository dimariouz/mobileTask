//
//  ServicesTests.swift
//  mobileTaskTests
//
//  Created by Dmitry Doroshchuk on 05.03.2023.
//

import XCTest
@testable import mobileTask

final class ServicesTests: XCTestCase {
    
    func testNetworkService() async {
        let mock = MockNetworkService()
        mock.data = APIResponse<[mobileTask.User]>(page: 1, perPage: 2, total: 3, totalPages: 4, data: [.mockUser, .mockUser])
        
        let sut: APIResponse<[mobileTask.User]> = try! await mock.get(path: "some path")
        
        XCTAssertEqual(sut.data.count, 2)
        XCTAssertEqual(mock.path, "some path")
    }
    
    func testUserService() async {
        let network = MockNetworkService()
        network.data = APIResponse<[mobileTask.User]>(page: 3, perPage: 2, total: 3, totalPages: 4, data: [.mockUser, .mockUser])
        let userService = UsersService(networkService: network)
        
        let sut: UsersResponse = try! await userService.getUsersList(page: 3)
        
        XCTAssertEqual(sut.page, 3)
        XCTAssertEqual(sut.totalPages, 4)
        XCTAssertEqual(sut.users.count, 2)
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var data: Decodable?
    var path: String?
    
    func get<T: Decodable>(path: String) async throws -> T {
        self.path = path
        return data as! T
    }
}
