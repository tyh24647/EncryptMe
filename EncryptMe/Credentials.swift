//
//  Credentials.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class Credentials {
    private let kDefaultUsername = String.UserDefaults.DefaultUsername.rawValue
    private let kDefaultPassword = String.UserDefaults.DefaultPassword.rawValue
    
    var encryptionKey: String!
    
    var username: String! {
        get {
            return self.username ?? kDefaultUsername
        } set {
            self.username = newValue ?? kDefaultUsername
        }
    }
    
    var password: String! {
        get {
            return self.password ?? kDefaultPassword
        } set {
            self.password = newValue ?? kDefaultPassword
        }
    }
    
    init() {
        initDefaultCredentials()
    }
    
    init(withUsername username: String!, password: String!) {
        initCredentials(withUsername: username, password: password)
    }
    
    fileprivate func initCredentials(withUsername username: String!, password: String!) -> Void {
        self.username = username ?? kDefaultUsername
        self.password = password ?? kDefaultPassword
        self.encryptionKey = generateEncryptionKey()
    }
    
    fileprivate func initDefaultCredentials() -> Void {
        self.username = kDefaultUsername
        self.password = kDefaultPassword
        self.encryptionKey = generateEncryptionKey()
    }
    
    fileprivate func generateEncryptionKey() -> String {
        var encKey: String!
        
        // TODO encryption
        
        return encKey
    }
}

