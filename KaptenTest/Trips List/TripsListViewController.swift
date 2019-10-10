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
import Nuke

final class TripsListViewController: UIViewController {
    private let navigator: TripsNavigator
    
    private var tripsListView: TripsListView!
    private let viewModel: TripsListViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: TripsListViewModelProtocol = TripsListViewModel(),
         navigator: TripsNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        tripsListView = TripsListView()
        tripsListView.delegate = self
        self.view = tripsListView
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
                        cell.setData(model)
                        if let url = model.imageUrl {
                            Nuke.loadImage(
                                with: url,
                                options: ImageLoadingOptions(
                                    transition: .fadeIn(duration: 0.33)
                                ),
                                into: cell.avatarImageView
                            )
                        }
        }.disposed(by: disposeBag)
        
        viewModel.viewState
            .asObservable()
            .subscribe(onNext: { [weak self] state in 
                guard let self = self else { return }
                self.tripsListView.setViewState(state)
            }).disposed(by: disposeBag)
    }
}

extension TripsListViewController: TripsListViewDelegate {
    func tripsListViewRetryButtonDidTap(_ view: TripsListView) {
        viewModel.refreshTrips()
    }
    
    func tripsListView(_ view: TripsListView,
                       didSelectTripAt index: Int) {
        let vm = viewModel.detailsViewModel(at: index)
        navigator.navigate(to: .tripDetails(viewModel: vm))
    }
    
    func tripsListView(_ view: TripsListView,
                       heightForCellAt index: Int) -> CGFloat {
        return viewModel.hasRating(at: index) ? 116 : 88
    }
}
