//
//  NetworkingService.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

enum ApiError: Error {
    case requestFailed
    case responseMappingFailed
}

protocol NetworkingService {
    func getData(with url: URL) -> Observable<Data>
}

class AlamofireNetworkingService: NetworkingService {
    func getData(with url: URL) -> Observable<Data> {
        return requestData(.get, url).map { response, data in
            guard response.statusCode == 200 else {
                throw ApiError.requestFailed
            }
            
            return data
        }
    }
}
