//
//  NetworkingServiceMock.swift
//  KaptenTestTests
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation
import RxSwift
@testable import KaptenTest

class TripsNetworkingServiceMock: NetworkingService {
    func getData(with url: URL) -> Observable<Data> {
        return Observable.just(createDataFromJSON())
    }
    
    // MARK: Private
    private func createDataFromJSON() -> Data {
        let bundle = Bundle(for: TripTests.self)
        let url = bundle.url(forResource: "Trips", withExtension: "json")!
        return try! Data(contentsOf: url,
                         options: .mappedIfSafe)
    }
}
