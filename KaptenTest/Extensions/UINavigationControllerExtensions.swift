//
//  UINavigationControllerExtensions.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

extension UINavigationController {
    func styleNavigationBar() {
        navigationBar.barTintColor = .clear
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .clear
    }
}
