//
//  StarwarsAPI.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation
import RxSwift

protocol StarwarsAPIProtocol {
    func trips() -> Observable<[Trip]>
}

class StarwarsAPI: StarwarsAPIProtocol {
    private enum Address: String {
        case trips = "trips"
        
        var baseURL: String { return "https://starwars.kapten.com/" }
        
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    
    private let networkingService: NetworkingService
    private let mappingScheduler: ImmediateSchedulerType
    
    init(networkingService: NetworkingService = AlamofireNetworkingService(),
         mappingScheduler: ImmediateSchedulerType = SerialDispatchQueueScheduler(qos: .background)) {
        self.networkingService = networkingService
        self.mappingScheduler = mappingScheduler
    }
    
    func trips() -> Observable<[Trip]> {
        return networkingService
            .getData(with: Address.trips.url)
            .observeOn(mappingScheduler)
            .map { data in
                do {
                    return try JSONDecoder().decode([Trip].self,
                                                    from: data)
                } catch {
                    throw ApiError.responseMappingFailed
                }
        }
    }
}
