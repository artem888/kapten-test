//
//  TripDetailsViewController.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit
import Nuke

final class TripDetailsViewController: UIViewController {
    private var tripDetailsView: TripDetailsView!
    private let viewModel: TripDetailsViewModelProtocol
    
    init(viewModel: TripDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        tripDetailsView = TripDetailsView(viewData: viewModel)
        self.view = tripDetailsView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = " "
        tripDetailsView.render()
        updateAvatarImage()
    }
    
    // MARK: Private
    private func updateAvatarImage() {
        if let url = viewModel.avatarImageUrl {
            Nuke.loadImage(
                with: url,
                options: ImageLoadingOptions(
                    transition: .fadeIn(duration: 0.33)
                ),
                into: tripDetailsView.avatarImageView
            )
        }
    }
}
