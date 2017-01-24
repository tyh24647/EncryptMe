//
//  LoginManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class LoginManager {
    var credentials: Credentials!
    var username: String!
    var password: String!
    var loggedIn: Bool!
    
    init() {
        #if DEBUG
            self.username = String.UserDefaults.DebugUsername.rawValue
            self.password = String.UserDefaults.DebugPassword.rawValue
        #else
            self.username = String.UserDefaults.DefaultUsername.rawValue
            self.loggedIn = makeLoginAttempt()
        #endif
    }
    
    init(withCredentials credentials: Credentials!) {
        self.credentials = credentials ?? Credentials(withUsername: username, password: password)
        self.username = self.credentials.username
        self.password = self.credentials.password
        self.loggedIn = false
    }
    
    func login() {
        
    }
    
    fileprivate func makeLoginAttempt() -> Bool! {
        var success = false
        
        // TODO: make methods to log in
        
        return success
    }
}



