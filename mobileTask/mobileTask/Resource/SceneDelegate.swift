//
//  SceneDelegate.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        self.window = UIWindow(windowScene: windowScene)
        
        let view: SplashView = .instantiate(storyboard: .splash)
        self.window?.rootViewController = UINavigationController(rootViewController: view)
        self.window?.makeKeyAndVisible()
    }
}

