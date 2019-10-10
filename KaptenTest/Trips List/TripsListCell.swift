//
//  TripsListCell.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

class TripsListCell: UITableViewCell {
    private(set) var avatarImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private func render() {
        self.backgroundColor = .clear
        self.avatarImageView = createAvatarImageView()
    }
    
    private func createAvatarImageView() -> UIImageView {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iv)
        NSLayoutConstraint.activate([
            iv.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                        constant: UIConstants.defaultPadding),
            iv.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            iv.widthAnchor.constraint(equalToConstant: 56),
            iv.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        return iv
    }
}
