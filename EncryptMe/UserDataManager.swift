//
//  UserDataManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

open class UserDataManager {
    
    var shouldCreateUserPlist: Bool
    
    init() {
        initDefaults()
    }
    
    func genrateUserPlistFile(withCompletion completion: (Bool, NSError) -> Void) {
        do {
            try 
        } catch <#pattern#> {
            <#statements#>
        }
    }
    
    fileprivate func initDefaults() -> Void {
        shouldCreateUserPlist = true
    }
}


