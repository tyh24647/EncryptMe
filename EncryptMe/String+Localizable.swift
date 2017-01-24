//
//  String+Localizable.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

extension String {
    static let Empty = ""
    
    func localized() -> String {
        return NSLocalizedString(self, comment: .Empty)
    }
    
    func localizedWithComment(comment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: .Empty, comment: comment)
    }
}

