//
//  UserDataManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

open class UserDataManager {
    
    //static let kDefaultFilePath = AppDefaults.DocumentPaths.Default
    var shouldCreateUserPlist: Bool!
    var appDefaults: AppDefaults!
    var appData: AppData!
    var user: User!
    var userPlistPath: String!
    var userPlistData: [String:String]
    
    init() {
        initDefaults()
    }
    
    init(withData data: AppData!) {
        self.appData = data
        initDefaults()
    }
    
    init(withUser user: User!) {
        self.user = user
        initDefaults()
    }
    
    func genrateUserPlistFile(withCompletion completion: (Bool, NSError) -> Void) throws -> String {
        do {
            
            try userPlistData = generatePlistJSONData({ success, err in
                
                // TODO figure this out
                
            })
        } catch let e as NSError {
            Console.Err(errMsg: e.localizedDescription)
            throw NSException(name: NSExceptionName(rawValue: "InvalidFileNameException"), reason: "Unable to create file with the specified name", userInfo: nil) as! Error
        }
    }
    
    fileprivate func initDefaults() -> Void {
        shouldCreateUserPlist = true
        self.appDefaults = AppDefaults()
        self.userPlistPath = appDefaults.path.appending("/user-profile.plist")
        
        self.userPlistData = generatePlistJSONData(completion: { success, err in
            Console.Log(debugMsg: <#T##String!#>)
        })
    }
    
    fileprivate func generatePlistJSONData(completion handler:(Bool, NSError) -> Void) -> [String:String] {
        var username: String!
        var password: String!
        var success = false
        var data: [String: String]!
        
        if appData.savedUser != nil {
            self.user = appData.savedUser
            username = user.username
            password = user.password
        }
        
        if user != nil {
            if appData != nil {
                data = [
                    "User": user.username,
                    "": ""
                ]
            
                success = true
            } else {
                //if self.appData
            }
        } else {
            user = User(withUsername: String.UserDefaults.AdminUsername, password: , isAdmin: <#T##Bool#>)
        }
        
        
        
        if data.count == 0 {
            handler(success, NSError())
        }
        
        return data
    }
}


