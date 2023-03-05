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
    @IBOutlet private weak var noFavLabel: UILabel!
    
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
            if !isLoading {
                self.tableView.tableFooterView = nil
            }
            self.animateIndicator(isLoading && self.model.usersList.isEmpty)
        }
    }
    
    private func setupUI() {
        setBackButtonHidden(true)
        title = C.title
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(showFavorites))
    }
    
    @objc private func showFavorites() {
        model.filterFavorites()
        noFavLabel.isHidden = !model.usersList.isEmpty
        tableView.reloadData()
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
    
    private func footerView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = model.usersList.count - 1
        if indexPath.row == lastItem && !model.showFavoriteOnly {
            if model.currentPage < model.totalPages {
                let page = model.currentPage + 1
                tableView.tableFooterView = footerView()
                // a small delay for animating footer, the second page loading too fast
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.model.fetchUsers(page: page)
                }
            }
        }
    }
}
