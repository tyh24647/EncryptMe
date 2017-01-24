//
//  DataModel.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class DataModel {
    var rootDirectory: String!
    var recentDirectory: String!
    var user: User!
    
    init() {
        setupDefaultUser()
        
    }
    
    func setupDefaultUser() -> Void {
        user = User.init()
        user.username = "default"
        user.password = "test"
    }
    
}
