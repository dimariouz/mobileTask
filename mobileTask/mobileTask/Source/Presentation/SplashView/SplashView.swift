//
//  SplashView.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

final class SplashView: RootViewController {
    private enum C {
        static let routeDelay: TimeInterval = 1.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeToUsersListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true)
    }
    
    private func routeToUsersListView() {
        let view: UsersListView = .instantiate(storyboard: .usersList)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + C.routeDelay) {
            self.push(to: view)
        }
    }
}
