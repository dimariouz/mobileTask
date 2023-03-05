//
//  ActivityIndicatorPresenter.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

protocol ActivityIndicatorPresenter: AnyObject {
    var activityIndicator: UIActivityIndicatorView { get }
    func animateIndicator(_ animate: Bool)
}

extension ActivityIndicatorPresenter where Self: UIViewController {
    func animateIndicator(_ animate: Bool) {
        if animate {
            view.addSubview(activityIndicator)
            activityIndicator.center = view.center
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
