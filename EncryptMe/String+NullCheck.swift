//
//  String+NullCheck.swift
//  EncryptMe
//
//  Created by Tyler hostager on 2/12/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

extension String {
    func isNullOrEmpty() -> Bool {
        return self.isEmpty || self == ""
    }
}
