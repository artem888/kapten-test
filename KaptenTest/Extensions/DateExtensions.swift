//
//  DateExtensions.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 11/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM HH:mm"
        return dateFormatter.string(from: self)
    }
}
