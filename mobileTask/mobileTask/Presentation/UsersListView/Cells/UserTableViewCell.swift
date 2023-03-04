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
    @IBOutlet private weak var addToFavButton: UIButton!
    
    private var model: User?
    
    var addToFavClosure: Closure<Void>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        lastNameLabel.text = nil
        emailLabel.text = nil
        avatarImageView.cancelLoading()
        avatarImageView.image = nil
        addToFavButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    func configure(model: User) {
        self.model = model
        nameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
        emailLabel.text = "Email: \(model.email)"
        avatarImageView.downloaded(from: model.avatar)
        let isFavorite = model.isFavorite ? "star.fill" : "star"
        addToFavButton.setImage(UIImage(systemName: isFavorite), for: .normal)
    }
    
    @IBAction private func addToFavButtonAction(_ sender: UIButton) {
        addToFavClosure?(())
        guard let model else { return }
        let isFavorite = model.isFavorite ? "star" : "star.fill"
        addToFavButton.setImage(UIImage(systemName: isFavorite), for: .normal)
    }
}
