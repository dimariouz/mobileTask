//
//  UIViewController.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

extension UIViewController {
    
    static var name: String {
        String(describing: self)
    }
    
    static func instantiate<T: UIViewController>(storyboard: Constants.Storyboards) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: T.name) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.name) ")
        }
        return view
    }
    
}
