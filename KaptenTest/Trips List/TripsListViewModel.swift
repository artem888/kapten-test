//
//  TripsListViewModel.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TripCellData {
    var title: String { get }
    var from: String { get }
    var to: String { get }
    var imageUrl: URL? { get }
    var hasRating: Bool { get }
    var rating: Int { get }
}

extension Trip: TripCellData {
    var hasRating: Bool {
        return pilotRating > 0.0
    }
    
    var title: String {
        pilotName.uppercased()
    }
    
    var from: String {
        pickupName
    }
    
    var to: String {
        dropoffName
    }
    
    var imageUrl: URL? {
        URL(string: "\(StarwarsAPI.baseURL)\(pilotAvatar)")
    }
    
    var rating: Int {
        return Int(pilotRating.rounded())
    }
}

protocol TripsListViewModelProtocol {
    var api: StarwarsAPIProtocol { get }
    var tripsData: Driver<[TripCellData]> { get }
    var viewState: Driver<TripsListViewModel.ViewState> { get }
    
    func refreshTrips()
    func hasRating(at index: Int) -> Bool
}

final class TripsListViewModel: TripsListViewModelProtocol {
    enum ViewState: Equatable {
        case error
        case loading
        case finished
    }
    
    var api: StarwarsAPIProtocol
    var tripsData: Driver<[TripCellData]>
    var viewState: Driver<TripsListViewModel.ViewState>
    
    private var tripsRelay = BehaviorRelay<[Trip]>(value: [])
    private var loadingRelay = BehaviorRelay<Bool>(value: false)
    
    private let bag = DisposeBag()
    
    init(api: StarwarsAPIProtocol = StarwarsAPI()) {
        self.api = api
        self.tripsData = Driver.empty()
        self.viewState = Driver.empty()
        rxBind()
    }
    
    func refreshTrips() {
        loadingRelay.accept(true)
        
        api.trips().subscribe(onNext: { [weak self] trips in
            guard let self = self else { return }
            self.tripsRelay.accept(trips)
            self.loadingRelay.accept(false)
        }, onError: { [weak self] _ in
            guard let self = self else { return }
            self.tripsRelay.accept([])
            self.loadingRelay.accept(false)
        }).disposed(by: bag)
    }
    
    func hasRating(at index: Int) -> Bool {
        return tripsRelay.value[index].hasRating
    }
    
    // MARK: Private
    private func rxBind() {
        tripsData = tripsRelay
            .map { $0 as [TripCellData] }
            .asDriver(onErrorJustReturn: [])
        
        viewState = Observable.combineLatest(loadingRelay, tripsRelay)
            .map { (loading, trips) -> ViewState in
                if loading {
                    return .loading
                } else if trips.isEmpty {
                    return .error
                } else {
                    return .finished
                }
            }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: .error)
    }
}
