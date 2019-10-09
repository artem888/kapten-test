//
//  NSAttributedStringExtensions.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

extension NSAttributedString {
    class func navigationAttributedTitle(with text: String) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: text,
                                      attributes: [
                                        .font: UIFont.systemFont(ofSize: 17.0,
                                                                 weight: .semibold),
                                        .foregroundColor: UIColor.white,
                                        .kern: 3.0
            ])
        attributedString.addAttribute(.kern,
                                      value: 0.0,
                                      range: NSRange(location: text.count - 1,
                                                     length: 1))
        
        return attributedString
    }
}
