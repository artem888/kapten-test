//
//  TripsListCell.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

class TripsListCell: UITableViewCell {
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
    }
    
    private func createAvatarImageView() -> UIImageView {
        let iv = UIImageView()
        
        return iv
    }
}
