//
//  TripDetailsView.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

final class TripDetailsView: UIView {
    private let viewData: TripDetailsViewModelProtocol
    private(set) var avatarImageView: UIImageView!
    private var separatorView: UIView!
    private var departureInfoStack: UIStackView!
    private var arrivalInfoStack: UIStackView!
    private var distanceInfoStack: UIStackView!
    
    init(viewData: TripDetailsViewModelProtocol) {
        self.viewData = viewData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.backgroundColor = .black
        createBackgroundImageView()
        avatarImageView = createAvatarImageView()
        createPilotNameLabel()
        separatorView = createSeparatorView()
        departureInfoStack = createDepartureInfoStack()
        arrivalInfoStack = createArrivalInfoStack()
        distanceInfoStack = createDistanceInfoStack()
        createDurationInfoStack()
        createPilotRatingStack()
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
                                        constant: ViewConstants.bigPadding),
            iv.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstants.defaultPadding),
            iv.widthAnchor.constraint(equalToConstant: 72),
            iv.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        return iv
    }
    
    private func createPilotNameLabel() {
        let l = UILabel()
        l.attributedText = .detailsTitle(with: viewData.pilotName)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.7
        l.translatesAutoresizingMaskIntoConstraints = false
        addSubview(l)
        NSLayoutConstraint.activate([
            l.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                       constant: ViewConstants.bigPadding),
            l.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            l.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                        constant: -ViewConstants.defaultPadding)
        ])
    }
    
    private func createSeparatorView() -> UIView {
        let v = UIView()
        v.backgroundColor = .separaratorColor
        v.translatesAutoresizingMaskIntoConstraints = false
        addSubview(v)
        NSLayoutConstraint.activate([
            v.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            v.heightAnchor.constraint(equalToConstant: 1),
            v.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,
                                   constant: ViewConstants.bigPadding)
        ])
        
        return v
    }
    
    private func createDepartureInfoStack() -> UIStackView {
        let subviews = [
            createStackTitleLabel(with: "Departure"),
            createStackSubtitleLabel(with: viewData.from),
            createTimeLabel(with: viewData.fromDate)
        ]
        
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 8
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: ViewConstants.bigPadding),
            sv.topAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                    constant: ViewConstants.bigPadding)
        ])
        
        return sv
    }
    
    private func createArrivalInfoStack() -> UIStackView {
        let subviews = [
            createStackTitleLabel(with: "Arrival"),
            createStackSubtitleLabel(with: viewData.to),
            createTimeLabel(with: viewData.toDate)
        ]
        
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 8
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                    constant: ViewConstants.bigPadding)
        ])
        
        return sv
    }
    
    private func createDistanceInfoStack() -> UIStackView {
        let subviews = [
            createStackTitleLabel(with: "Distance"),
            createStackSubtitleLabel(with: viewData.distance)
        ]
        
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 8
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: ViewConstants.bigPadding),
            sv.topAnchor.constraint(equalTo: departureInfoStack.bottomAnchor,
                                    constant: ViewConstants.bigPadding)
        ])
        
        return sv
    }
    
    private func createDurationInfoStack() {
        let subviews = [
            createStackTitleLabel(with: "Trip Duration"),
            createStackSubtitleLabel(with: viewData.duration)
        ]
        
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 8
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.arrivalInfoStack.leadingAnchor),
            sv.leadingAnchor.constraint(equalTo: self.distanceInfoStack.trailingAnchor,
                                        constant: 39),
            sv.topAnchor.constraint(equalTo: distanceInfoStack.topAnchor)
        ])
    }
    
    private func createPilotRatingStack() {
        let subviews = [
            createStackTitleLabel(with: "Pilot Rating"),
            viewData.hasRating ?
            createRatingView(with: viewData.pilotRating) :
            createTimeLabel(with: "USER DIDN'T RATE YET")
        ]
        
        let sv = UIStackView(arrangedSubviews: subviews)
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = viewData.hasRating ? 8 : ViewConstants.bigPadding
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: ViewConstants.bigPadding),
            sv.topAnchor.constraint(equalTo: distanceInfoStack.bottomAnchor,
                                    constant: ViewConstants.bigPadding)
        ])
    }
    
    private func createStackTitleLabel(with title: String) -> UILabel {
        let l = UILabel()
        l.textAlignment = .left
        l.attributedText = .cellSubtitle(with: title)
        return l
    }
    
    private func createStackSubtitleLabel(with title: String) -> UILabel {
        let l = UILabel()
        l.textAlignment = .left
        l.attributedText = .cellTitle(with: title)
        return l
    }
    
    private func createTimeLabel(with title: String) -> UILabel {
        let l = UILabel()
        l.textAlignment = .left
        l.attributedText = .time(with: title)
        return l
    }
    
    private func createRatingView(with rating: Int) -> RatingView {
        return RatingView(rating: rating,
                          normalImage: UIImage(named: "StarBigEmpty")!,
                          selectedImage: UIImage(named: "StarBigFilled")!,
                          imageSize: 40)
    }
}
