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
        var subviews: [UIView] = [
            createTitleLabel(with: cellData.title),
            createFromToLabelsView(with: cellData.from,
                                   to: cellData.to)
        ]
        if cellData.hasRating {
            subviews.append(createRatingView(with: cellData.rating))
        }
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 8.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor,
                                        constant: ViewConstants.defaultPadding),
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
                                        constant: ViewConstants.defaultPadding),
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
    
    private func createFromToLabelsView(with from: String,
                                        to: String) -> UIView {
        let v = UIView()
        
        let fromLabel = UILabel()
        fromLabel.textAlignment = .left
        fromLabel.attributedText = .cellSubtitle(with: from)
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(fromLabel)
        NSLayoutConstraint.activate([
            fromLabel.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            fromLabel.topAnchor.constraint(equalTo: v.topAnchor),
            fromLabel.bottomAnchor.constraint(equalTo: v.bottomAnchor)
        ])
        
        let arrowImageView = UIImageView(image: UIImage(named: "Arrow"))
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor,
                                                    constant: ViewConstants.defaultPadding)
        ])
        
        let toLabel = UILabel()
        toLabel.textAlignment = .left
        toLabel.attributedText = .cellSubtitle(with: to)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(toLabel)
        NSLayoutConstraint.activate([
            toLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor,
                                             constant: ViewConstants.defaultPadding),
            toLabel.topAnchor.constraint(equalTo: v.topAnchor),
            toLabel.bottomAnchor.constraint(equalTo: v.bottomAnchor)
        ])
        
        return v
    }
    
    private func createRatingView(with rating: Int) -> RatingView {
        return RatingView(rating: rating,
                          normalImage: UIImage(named: "SmallStarEmpty")!,
                          selectedImage: UIImage(named: "SmallStarFilled")!,
                          imageSize: 24)
    }
}
