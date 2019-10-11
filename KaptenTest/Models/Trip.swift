//
//  Trip.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation

struct Trip {
    let id: Int
    let pilotName: String
    let pilotAvatar: String
    let pilotRating: Double
    let pickupName: String
    let pickupDate: String
    let dropoffName: String
    let dropoffDate: String
    let distanceValue: Int
    let distanceUnit: String
    let duration: Int
}

extension Trip: Decodable {
    private struct Pilot: Decodable {
        let name: String
        let avatar: String
        let rating: Double
    }
    
    private struct Pickup: Decodable {
        let name: String
        let date: String
    }
    
    private struct Dropoff: Decodable {
        let name: String
        let date: String
    }
    
    private struct Distance: Decodable {
        let value: Int
        let unit: String
    }
    
    private enum CodingKeys: String, CodingKey {
      case id, pilot, distance, duration, pickup = "pick_up", dropoff = "drop_off"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        duration = try container.decode(Int.self, forKey: .duration)

        let pilot = try container.decode(Pilot.self, forKey: .pilot)
        pilotName = pilot.name
        pilotAvatar = pilot.avatar
        pilotRating = pilot.rating
        
        let pickup = try container.decode(Pickup.self, forKey: .pickup)
        pickupName = pickup.name
        pickupDate = pickup.date
        
        let dropoff = try container.decode(Dropoff.self, forKey: .dropoff)
        dropoffName = dropoff.name
        dropoffDate = dropoff.date
        
        let distance = try container.decode(Distance.self, forKey: .distance)
        distanceValue = distance.value
        distanceUnit = distance.unit
    }
}
