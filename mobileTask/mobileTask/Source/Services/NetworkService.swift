//
//  NetworkService.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    func get<T: Decodable>(path: String) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private var session: Session!
    
    func get<T: Decodable>(path: String) async throws ->  T {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache?.removeAllCachedResponses()
        session = Session(configuration: configuration)
        return try await session.request(Constants.APIs.host + path,
                                         method: .get)
        .serializingDecodable(T.self).value
    }
}
