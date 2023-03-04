//
//  ViewModelHandleProtocol.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import Foundation

protocol ViewModelHandleProtocol: AnyObject {
    var didReceiveError: Closure<Error>? { get }
    var didReceiveResult: Closure<Void>? { get }
    var isLoading: Closure<Bool>? { get }
}
