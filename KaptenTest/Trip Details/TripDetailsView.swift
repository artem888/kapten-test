//
//  TripDetailsView.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

final class TripDetailsView: UIView {
    func render() {
        self.backgroundColor = .black
        createBackgroundImageView()
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
}
