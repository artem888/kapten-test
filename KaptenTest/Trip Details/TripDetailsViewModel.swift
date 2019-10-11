//
//  TripDetailsViewModel.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 10/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation

protocol TripDetailsViewModelProtocol {
    var avatarImageUrl: URL? { get }
}

final class TripDetailsViewModel: TripDetailsViewModelProtocol {
    var avatarImageUrl: URL? {
        trip.imageUrl
    }
    
    private let trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
}
