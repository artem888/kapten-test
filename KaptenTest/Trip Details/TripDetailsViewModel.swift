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
    var pilotName: String { get }
}

final class TripDetailsViewModel: TripDetailsViewModelProtocol {
    var pilotName: String {
        trip.pilotName.uppercased().replacingOccurrences(of: " ",
                                                         with: "\n")
    }
    
    var avatarImageUrl: URL? {
        trip.imageUrl
    }
    
    private let trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
}
