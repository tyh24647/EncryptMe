//
//  UserPreferences.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

struct UserPrefsModel {
    enum UserValidation {
        enum Admin {
            static let debugAdminOverride = true
            
            enum ValidAdminAccount {
                case standardAdmin
                case iCloudAdmin
                case dropboxAdmin
                case oneDriveAdmin
                case megaAdmin
                case otherAdmin
            }
            
            enum InvalidAdminAccount {
                case invalidCloudConfigs
                case invalidUsername
                case missingUsername
                case invalidPassword
                case missingPassword
                case noAcccount
                case needsLogin
                case isLockedOut
                
            }
        }
        
        case validAdminAccount
        case validDefaultAccount
    }
    
    enum Permissions {
        case isAdmin
        case defaultUser
    }
    
    let canAddFiles: Bool!
    let canModifyFiles: Bool!
    let canRemoveFiles: Bool!
    let canAddDirectories: Bool!
    let canModifyDirectories: Bool!
    let canRemoveDirectories: Bool!
}



