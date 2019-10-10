//
//  TripsNavigator.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

class TripsNavigator: Navigator {
    enum Destination {
        case tripDetails(viewModel: TripDetailsViewModelProtocol)
    }
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: Private

    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .tripDetails(let viewModel):
            return TripDetailsViewController(viewModel: viewModel)
        }
    }
}
