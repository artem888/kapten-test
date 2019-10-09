//
//  TripsListViewModelTests.swift
//  KaptenTestTests
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
@testable import KaptenTest

class TripsListViewModelTests: XCTestCase {
    private var sut: TripsListViewModel!
    private var apiMock: StarwarsAPIProtocolMock!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        createSUT(with: true)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        disposeBag = nil
        apiMock = nil
        sut = nil
    }

    func testRefreshTrips_tripsAPICalled() {
        XCTAssertFalse(apiMock.tripsWasCalled)
        sut.refreshTrips()
        XCTAssertTrue(apiMock.tripsWasCalled)
    }
    
    func testViewState_withSuccessResponse() {
        let observer = scheduler.createObserver(TripsListViewModel.ViewState.self)
        sut.viewState
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        sut.refreshTrips()
        let events = observer.events.compactMap { $0.value.element }
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events[0], .loading)
        XCTAssertEqual(events[1], .finished)
    }
    
    func testViewState_withErrorResponse() {
        createSUT(with: false)
        
        let observer = scheduler.createObserver(TripsListViewModel.ViewState.self)
        sut.viewState
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        sut.refreshTrips()
        let events = observer.events.compactMap { $0.value.element }
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events[0], .loading)
        XCTAssertEqual(events[1], .error)
    }
    
    func testTripsData_withSuccessResponse() {
        let observer = scheduler.createObserver([TripCellData].self)
        sut.tripsData
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        sut.refreshTrips()
        let events = observer.events.compactMap { $0.value.element }
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events[0].count, 0)
        XCTAssertEqual(events[1].count, 1)
        XCTAssertEqual(events[1][0].title, "Darth")
    }
    
    func testTripsData_withErrorResponse() {
        createSUT(with: false)
        
        let observer = scheduler.createObserver([TripCellData].self)
        sut.tripsData
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        sut.refreshTrips()
        let events = observer.events.compactMap { $0.value.element }
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events[0].count, 0)
        XCTAssertEqual(events[1].count, 0)
    }
    
    // MARK: Private
    private func createSUT(with success: Bool) {
        apiMock = StarwarsAPIProtocolMock(success: success)
        sut = TripsListViewModel(api: apiMock)
    }
}

class TripCellDataTests: XCTestCase {
    func testCellDataIsCorrect() {
        let trip: TripCellData = createTrip()
        XCTAssertEqual(trip.title, "Darth")
        XCTAssertEqual(trip.from, "Hoth")
        XCTAssertEqual(trip.to, "Tatooine")
        XCTAssertEqual(trip.imageUrl!, URL(string: "https://starwars.kapten.com/some_avatar.png"))
    }
    
    // MARK: Private
    private func createTrip() -> Trip {
        return Trip(id: 123,
                    pilotName: "Darth",
                    pilotAvatar: "/some_avatar.png",
                    pickupName: "Hoth",
                    dropoffName: "Tatooine")
    }
}
