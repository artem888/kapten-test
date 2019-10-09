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
