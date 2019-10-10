//
//  RatingView.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

final class RatingView: UIView {
    private let rating: Int
    private let normalImage: UIImage
    private let selectedImage: UIImage
    private let imageSize: CGFloat
    
    init(rating: Int,
         normalImage: UIImage,
         selectedImage: UIImage,
         imageSize: CGFloat) {
        assert(0 ... 5 ~= rating)
        
        self.rating = rating
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        self.imageSize = imageSize
        super.init(frame: .zero)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private func render() {
        backgroundColor = .clear
        createStackView()
    }
    
    private func createStackView() {
        let range = 1...5
        let stars: [UIView] = range.map { index in
            let star =  UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: self.imageSize,
                                                  height: self.imageSize))
            star.image = self.rating < index ?
                self.normalImage :
                self.selectedImage
            
            return star
        }
        
        let sv = UIStackView(arrangedSubviews: stars)
        sv.distribution = .equalSpacing
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sv.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sv.topAnchor.constraint(equalTo: self.topAnchor),
            sv.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sv.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
}
