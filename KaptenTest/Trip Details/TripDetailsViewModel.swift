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
    var from: String { get }
    var to: String { get }
    var fromDate: String { get }
    var toDate: String { get }
    var distance: String { get }
    var duration: String { get }
    var pilotRating: Int { get }
    var hasRating: Bool { get }
}

final class TripDetailsViewModel: TripDetailsViewModelProtocol {
    var hasRating: Bool {
        trip.hasRating
    }
    
    var pilotRating: Int {
        trip.rating
    }
    
    var duration: String {
        TimeInterval(trip.duration).timeStringFromMilliseconds()
    }
    
    var distance: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedDistance =
            numberFormatter.string(from: NSNumber(value: trip.distanceValue)) else { return "No distance" }
        return "\(formattedDistance) \(trip.distanceUnit.uppercased())"
    }
    
    var fromDate: String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: trip.pickupDate) else {
            return"No date"
        }
        
        return date.formattedString()
    }
    
    var toDate: String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: trip.dropoffDate) else {
            return"No date"
        }
        
        return date.formattedString()
    }
    
    var from: String {
        trip.pickupName.uppercased()
    }
    
    var to: String {
        trip.dropoffName.uppercased()
    }
    
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
