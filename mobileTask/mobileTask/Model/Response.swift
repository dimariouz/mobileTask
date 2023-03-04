//
//  Response.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case page, data, total
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}
