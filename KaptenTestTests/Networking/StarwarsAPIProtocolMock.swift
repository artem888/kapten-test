//
//  StarwarsAPIProtocolMock.swift
//  KaptenTestTests
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation
import RxSwift
@testable import KaptenTest

class StarwarsAPIProtocolMock: StarwarsAPIProtocol {
    var tripsWasCalled = false
    var success: Bool
    
    init(success: Bool) {
        self.success = success
    }
    
    func trips() -> Observable<[Trip]> {
        tripsWasCalled = true
        return success ?
            Observable.just(createTrips()) :
            Observable.error(ApiError.requestFailed)
    }
    
    // MARK: Private
    private func createTrips() -> [Trip] {
        return [
            Trip(id: 123,
                 pilotName: "Darth",
                 pilotAvatar: "/some_avatar.png",
                 pilotRating: 4.0,
                 pickupName: "Hoth",
                 dropoffName: "Tatooine")
        ]
    }
}
