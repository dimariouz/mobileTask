//
//  UsersListView.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

final class UsersListView: RootViewController {
    private enum C {
        static let cellHeight: CGFloat = 150
        static let title = "Users"
    }
    
    private let model = UsersListViewModel(platform: Platform.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        model.fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.reloadData()
    }
    
    private func setupBindings() {
        model.didReceiveResult = { [weak self] _ in
            guard let self = self else { return }
//            self.tableView.reloadData()
        }
        
        model.didReceiveError = { [weak self] error in
            guard let self = self else { return }
//            self.handleError(with: error)
        }
        
        model.isLoading = { [weak self] isLoading in
            guard let self = self else { return }
//            self.animateIndicator(isLoading)
        }
    }
    
    private func setupUI() {
        setBackButtonHidden(true)
        title = C.title
//        setupTableView()
    }
}
