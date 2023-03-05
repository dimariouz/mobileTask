//
//  UserDetailsView.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

final class UserDetailsView: RootViewController {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    private(set) var model = UserDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackButtonHidden(false)
        setupUI()
    }
    
    private func setupUI() {
        guard let model = model.user else { return }
        nameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
        emailLabel.text = "Email: \(model.email)"
        avatarImageView.downloaded(from: model.avatar)
    }
}
