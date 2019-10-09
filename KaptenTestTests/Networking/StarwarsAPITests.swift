//
//  StarwarsAPITests.swift
//  KaptenTestTests
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
@testable import KaptenTest

class StarwarsAPITests: XCTestCase {
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var sut: StarwarsAPI!
    private var networkingServiceMock: TripsNetworkingServiceMock!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        networkingServiceMock = TripsNetworkingServiceMock()
        sut = StarwarsAPI(networkingService: networkingServiceMock,
                          mappingScheduler: MainScheduler.instance)
    }

    override func tearDown() {
        scheduler = nil
        disposeBag = nil
    }

    func testTrips() {
        let observer = scheduler.createObserver([Trip].self)
        
        sut.trips()
            .subscribe(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        let events = observer.events.compactMap { $0.value.element }
        XCTAssertEqual(events.count, 1)
        let trips = events.first!
        XCTAssertEqual(trips.count, 7)
    }
}
