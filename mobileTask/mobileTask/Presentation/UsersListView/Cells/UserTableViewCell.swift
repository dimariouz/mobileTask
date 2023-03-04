//
//  UserTableViewCell.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit

final class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        lastNameLabel.text = nil
        emailLabel.text = nil
        avatarImageView.cancelLoading()
        avatarImageView.image = nil
    }
    
    func configure(model: User) {
        nameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
        emailLabel.text = "Email: \(model.email)"
        avatarImageView.downloaded(from: model.avatar)
    }
}
