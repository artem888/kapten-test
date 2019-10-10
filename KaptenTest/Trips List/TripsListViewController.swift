//
//  TripsListViewController.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TripsListViewController: UIViewController {
    private var tripsListView: TripsListView!
    private let viewModel: TripsListViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: TripsListViewModelProtocol = TripsListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.tripsListView = TripsListView()
        self.view = self.tripsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
        tripsListView.render()
        viewModel.refreshTrips()
        rxBind()
    }
    
    // MARK: Private
    private func styleNavBar() {
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.attributedText = .navigationAttributedTitle(with: "LAST TRIPS")
        self.navigationItem.titleView = navigationTitleLabel
    }
    
    private func rxBind() {
        viewModel.tripsData
            .drive(tripsListView.tableView
                .rx
                .items(cellIdentifier: UIConstants.tripsListCellIdentifier,
                       cellType: TripsListCell.self)) { index, model, cell in
                        cell.textLabel?.text = "test"
        }.disposed(by: disposeBag)
        
        viewModel.viewState
            .asObservable()
            .subscribe(onNext: { state in
                self.tripsListView.setViewState(state)
            }).disposed(by: disposeBag)
    }
}

extension TripsListViewController: TripsListViewDelegate {
    func tripsListViewRetryButtonDidTap(_ view: TripsListView) {
        viewModel.refreshTrips()
    }
    
    func tripsListView(_ view: TripsListView, didSelectTripAt index: Int) {
        
    }
}
