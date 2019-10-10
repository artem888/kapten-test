//
//  TripDetailsViewModel.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation

protocol TripDetailsViewModelProtocol {
    
}

final class TripDetailsViewModel: TripDetailsViewModelProtocol {
    private let trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
}
