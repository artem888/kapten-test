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
    let dropoffName: String
}

extension Trip: Decodable {
    private struct Pilot: Decodable {
        let name: String
        let avatar: String
        let rating: Double
    }
    
    private struct Pickup: Decodable {
        let name: String
    }
    
    private struct Dropoff: Decodable {
        let name: String
    }
    
    private enum CodingKeys: String, CodingKey {
      case id, pilot, pickup = "pick_up", dropoff = "drop_off"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)

        let pilot = try container.decode(Pilot.self, forKey: .pilot)
        pilotName = pilot.name
        pilotAvatar = pilot.avatar
        pilotRating = pilot.rating
        
        let pickup = try container.decode(Pickup.self, forKey: .pickup)
        pickupName = pickup.name
        
        let dropoff = try container.decode(Dropoff.self, forKey: .dropoff)
        dropoffName = dropoff.name
    }
}
