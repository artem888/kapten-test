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
    private var infoStackView: UIStackView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ cellData: TripCellData) {
        infoStackView?.removeFromSuperview()
        infoStackView = createInfoStackView(with: cellData)
    }
    
    // MARK: Private
    private func render() {
        self.backgroundColor = .clear
        self.avatarImageView = createAvatarImageView()
    }
    
    private func createInfoStackView(with cellData: TripCellData) -> UIStackView {
        let subviews: [UIView] = [
            createTitleLabel(with: cellData.title)
        ]
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor,
                                        constant: UIConstants.defaultPadding),
            sv.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                         constant: -UIConstants.defaultPadding),
            sv.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        return sv
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
    
    private func createTitleLabel(with title: String) -> UILabel {
        let l = UILabel()
        l.attributedText = .cellTitle(with: title)
        l.textAlignment = .left
        return l
    }
}
