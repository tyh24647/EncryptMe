//
//  LoginManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class LoginManager {
    var loggedIn: Bool!
    var username: String!
    var password: String!
    
    init() {
        #if DEBUG
            self.username = String.UserDefaults.DebugUsername.rawValue
            self.password = String.UserDefaults.DebugPassword.rawValue
        #else
            self.username = String.UserDefaults.DefaultUsername.rawValue
            self.loggedIn = makeLoginAttempt()
        #endif
    }
    
    fileprivate func makeLoginAttempt() -> Bool! {
        var success = false
        
        // TODO: make methods to log in
        
        return success
    }
}


