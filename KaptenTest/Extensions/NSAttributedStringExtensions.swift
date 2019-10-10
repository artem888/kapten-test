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
        return attributedString(with: text,
                                font: UIFont.systemFont(ofSize: 17.0,
                                                        weight: .semibold),
                                foregroundColor: UIColor.white)
    }
    
    class func cellTitle(with text: String) -> NSAttributedString {
        return attributedString(with: text,
                                font: UIFont.systemFont(ofSize: 15.0,
                                                        weight: .semibold),
                                foregroundColor: UIColor.white)
    }
    
    class func attributedString(with text: String,
                                font: UIFont,
                                foregroundColor: UIColor) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: text,
                                      attributes: [
                                        .font: font,
                                        .foregroundColor: foregroundColor,
                                        .kern: 3.0
            ])
        attributedString.addAttribute(.kern,
                                      value: 0.0,
                                      range: NSRange(location: text.count - 1,
                                                     length: 1))
        
        return attributedString
    }
}
