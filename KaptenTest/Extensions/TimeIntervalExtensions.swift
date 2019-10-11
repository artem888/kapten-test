//
//  TimeIntervalExtensions.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 11/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation

extension TimeInterval {
    func timeStringFromMilliseconds() -> String {
        let time = Int(self / 1000.0)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
}
