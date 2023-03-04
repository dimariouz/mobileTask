//
//  UIImageView.swift
//  mobileTask
//
//  Created by Dmitry Doroshchuk on 04.03.2023.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func cancelLoading() {
        self.af.cancelImageRequest()
    }
    
    func downloaded(from url: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let placeholder = UIImage(systemName: "user")
        guard let urlString = url, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        self.af.setImage(withURL: url, placeholderImage: placeholder)
    }
}
