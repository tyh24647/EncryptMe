//
//  Credentials.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class Credentials: User {
    private let kDefaultUsername = String.UserDefaults.DefaultUsername.rawValue
    private let kDefaultPassword = String.UserDefaults.DefaultPassword.rawValue
    
    var encryptionKey: String!
    
    override var username: String! {
        get {
            return self.username ?? kDefaultUsername
        } set {
            self.username = newValue ?? kDefaultUsername
        }
    }
    
    override var password: String! {
        get {
            return self.password ?? kDefaultPassword
        } set {
            self.password = newValue ?? kDefaultPassword
        }
    }
    
    override init() {
        initDefaults()
    }
    
    
    fileprivate func initDefaults() -> Void {
        self.username = kDefaultUsername
        self.password = kDefaultPassword
        self.encryptionKey = generateEncryptionKey()
    }
    
    fileprivate func generateEncryptionKey() -> String {
        var encKey: String
        
        // TODO encryption
        
        return encKey
    }
}

