//
//  UIView.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

