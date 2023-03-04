//
//  RootViewController.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

class RootViewController: UIViewController, AlertPresenter {
   
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator =  UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundColor()
//        setNavigationBarHidden()
    }
    
    func setupBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func push(to view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func setNavigationBarHidden(_ isHidden: Bool = false) {
        navigationController?.navigationBar.isHidden = isHidden
    }
    
    func setBackButtonHidden(_ isHidden: Bool) {
        navigationItem.setHidesBackButton(isHidden, animated: false)
    }

    func handleError(with error: Error) {
        showAlert(message: error.localizedDescription)
    }
}
