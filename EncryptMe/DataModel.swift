//
//  DataModel.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class DataModel {
    
    // MARK: Init constants
    let kDefaultUsername = String.UserDefaults.DefaultUsername.rawValue
    let kDefaultPassword = String.UserDefaults.DefaultPassword.rawValue
    
    // MARK: Init vars
    var rootDirectory: String!
    var recentDirectory: String!
    var user: User!
    
    // MARK: Constructors
    /// Default constructor
    init() {
        setupDefaultUser()
    }
    
    // MARK: Functions
    /// Initializes a user object with default values
    func setupDefaultUser() -> Void {
        user = User.init()
        user.username = kDefaultUsername 
        user.password = kDefaultPassword
    }
    
}
