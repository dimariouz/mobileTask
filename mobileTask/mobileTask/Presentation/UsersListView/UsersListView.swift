//
//  UsersListView.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

final class UsersListView: RootViewController {
    private enum C {
        static let title = "Users"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let model = UsersListViewModel(platform: Platform.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        model.fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupBindings() {
        model.didReceiveResult = { [weak self] _ in
            guard let self else { return }
            self.tableView.reloadData()
        }
        
        model.didReceiveError = { [weak self] error in
            guard let self else { return }
            self.handleError(with: error)
        }
        
        model.isLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                self.refreshControl.beginRefreshing()
            } else {
                self.refreshControl.endRefreshing()
            }
            self.animateIndicator(isLoading)
        }
    }
    
    private func setupUI() {
        setBackButtonHidden(true)
        title = C.title
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibs: [UserTableViewCell.self])
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        model.refreshFetch()
    }
    
    private func openSingleUser(with user: User) {
        let view: UserDetailsView = .instantiate(storyboard: .userDetails)
        view.model.user = user
        push(to: view)
    }
}

// MARK: - UITableViewDelegate
extension UsersListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openSingleUser(with: model.usersList[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension UsersListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: UserTableViewCell.self, forIndexPath: indexPath)
        cell.configure(model: model.usersList[indexPath.row])
        cell.addToFavClosure = { [weak self] _ in
            guard let self else { return }
            self.model.addToFavorite(user: self.model.usersList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = model.usersList.count - 1
        if indexPath.row == lastItem {
            if model.currentPage < model.totalPages {
                let page = model.currentPage + 1
                model.fetchUsers(page: page)
            }
        }
    }
}
