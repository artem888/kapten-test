//
//  TripDetailsViewController.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

final class TripDetailsViewController: UIViewController {
    private var tripDetailsView: TripDetailsView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        tripDetailsView = TripDetailsView()
        self.view = tripDetailsView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = " "
        tripDetailsView.render()
    }
}
