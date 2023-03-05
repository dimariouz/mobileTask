//
//  AlertPresenter.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

protocol AlertPresenter: AnyObject {
    func showAlert(title: String, message: String, actions: [UIAlertAction])
}

extension AlertPresenter where Self: UIViewController {
    func showAlert(title: String = "Error",
                   message: String,
                   actions: [UIAlertAction] = []) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
            }))
        } else {
            actions.forEach { action in
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
}
