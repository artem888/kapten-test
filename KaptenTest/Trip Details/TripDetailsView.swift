//
//  TripDetailsView.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

final class TripDetailsView: UIView {
    private(set) var avatarImageView: UIImageView!
    
    func render() {
        self.backgroundColor = .black
        createBackgroundImageView()
        avatarImageView = createAvatarImageView()
    }
    
    // MARK: Private
    private func createBackgroundImageView() {
        let iv = UIImageView(image: UIImage(named: "Background"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iv)
        NSLayoutConstraint.activate([
            iv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iv.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iv.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iv.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func createAvatarImageView() -> UIImageView {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iv)
        NSLayoutConstraint.activate([
            iv.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: 24),
            iv.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstants.defaultPadding),
            iv.widthAnchor.constraint(equalToConstant: 72),
            iv.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        return iv
    }
}
