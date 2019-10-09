//
//  TripsListViewController.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

class TripsListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
    }
    
    // MARK: Private
    private func styleNavBar() {
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.attributedText = .navigationAttributedTitle(with: "LAST TRIPS")
        self.navigationItem.titleView = navigationTitleLabel
    }
}

