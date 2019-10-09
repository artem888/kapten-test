//
//  TripsListViewController.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

final class TripsListViewController: UIViewController {
    private var tripsListView: TripsListView!
    
    override func loadView() {
        self.tripsListView = TripsListView()
        self.view = self.tripsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
        tripsListView.render()
    }
    
    // MARK: Private
    private func styleNavBar() {
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.attributedText = .navigationAttributedTitle(with: "LAST TRIPS")
        self.navigationItem.titleView = navigationTitleLabel
    }
}

