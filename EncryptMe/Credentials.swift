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
    
    /// Default constructor
    init() {
        initDefaultCredentials()
    }
    
    /// Constructs a credentials object with the specified username and password
    ///
    /// - Parameters:
    ///   - username: The username to add
    ///   - password: The password to add
    init(withUsername username: String!, password: String!) {
        initCredentials(withUsername: username, password: password)
    }
    
    /// Initializes a Credentials object with the specified username and password, and
    /// an encryption key to be associated with the user and later used for encryption
    ///
    /// - Parameters:
    ///   - username: The username to add
    ///   - password: The password to add
    fileprivate func initCredentials(withUsername username: String!, password: String!) -> Void {
        self.username = username ?? kDefaultUsername
        self.password = password ?? kDefaultPassword
        self.encryptionKey = generateEncryptionKey()
    }
    
    /// Initializes a default credentials object
    fileprivate func initDefaultCredentials() -> Void {
        self.username = kDefaultUsername
        self.password = kDefaultPassword
        self.encryptionKey = generateEncryptionKey()
    }
    
    /// Generates a new encryption key based on hashes of the user's information, which
    /// allows for a unique, random encryption key which can be later used to read/write files
    ///
    /// - Returns: The encryption key for the specific user
    fileprivate func generateEncryptionKey() -> String {
        var encKey: String!
        
        // TODO encryption
        
        return encKey
    }
}

