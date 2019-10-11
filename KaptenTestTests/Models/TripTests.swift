//
//  TripTests.swift
//  KaptenTestTests
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import XCTest
@testable import KaptenTest

class TripTests: XCTestCase {
    func testDecodingFromJson() {
        let trip = createTripFromJson()
        XCTAssertEqual(trip.id, 1)
        XCTAssertEqual(trip.pilotName, "Dark Vador")
        XCTAssertEqual(trip.pilotAvatar, "/static/dark-vador.png")
        XCTAssertEqual(trip.pickupName, "Yavin 4")
        XCTAssertEqual(trip.dropoffName, "Naboo")
        XCTAssertEqual(trip.pilotRating, 5.0)
        XCTAssertEqual(trip.distanceUnit, "km")
        XCTAssertEqual(trip.distanceValue, 2478572)
        XCTAssertEqual(trip.duration, 19427000)
        XCTAssertEqual(trip.pickupDate, "2017-12-09T14:12:51Z")
        XCTAssertEqual(trip.dropoffDate, "2017-12-09T19:35:51Z")
    }
    
    // MARK: Private
    private func createTripFromJson() -> Trip {
        let bundle = Bundle(for: TripTests.self)
        let url = bundle.url(forResource: "Trip", withExtension: "json")!
        let data = try! Data(contentsOf: url,
                             options: .mappedIfSafe)
        return try! JSONDecoder().decode(Trip.self,
                                         from: data)
    }
}
