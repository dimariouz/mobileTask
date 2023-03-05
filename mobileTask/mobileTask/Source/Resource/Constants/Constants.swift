//
//  Constants.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

typealias Closure<T> = (T) -> Void

enum Constants {
    enum Storyboards: String {
        case splash = "Splash"
        case usersList = "UsersList"
        case userDetails = "UserDetails"
    }
    
    enum APIs {
        static var host: String {
            "https://reqres.in"
        }
    }
}
