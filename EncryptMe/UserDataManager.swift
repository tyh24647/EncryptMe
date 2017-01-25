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
    //var userPlistData: [String:String]
    var userPlistData: NSMutableDictionary!
    
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
            
            try userPlistData = generatePlistJSONData(completion: { success, err in
                
                // TODO figure this out
                
                /*
                if err != nil {
                    throw err
                }
 */
            })
        } catch let e as Error {
            Console.Err(errMsg: e.localizedDescription)
            throw NSException(name: NSExceptionName(rawValue: "InvalidFileNameException"), reason: "Unable to create file with the specified name", userInfo: nil) as! Error
        }
        
        return userPlistData.debugDescription
    }
    
    fileprivate func initDefaults() -> Void {
        let userProfilePlistName = String.FileTypes.PropertyList.rawValue
        
        self.shouldCreateUserPlist = true
        self.appDefaults = AppDefaults()
        self.userPlistPath = appDefaults.path.appending(userProfilePlistName)
        
        if !self.appDefaults.file.exists(userProfilePlistName) {
            Console.Debug(debugMsg: "Generating user property list file")
            self.userPlistData = generatePlistJSONData(completion: { success, err in
                if success {
                    Console.Debug(debugMsg: "User property list file generated successfully")
                }
            })
        } else {
            if let fileUrl = Bundle.main.url(forResource: userProfilePlistName, withExtension: userProfilePlistName),
                let data = try? Data(contentsOf: fileUrl) {
                if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] {
                    Console.Debug(debugMsg: result?.description)
                }
            }
        }
    }
    
    fileprivate func generatePlistJSONData(completion handler:(Bool, NSError) -> Void) -> NSMutableDictionary {
        var defaultUsername: String!
        var defaultPassword: String!
        var username: String!
        var password: String!
        var success = false
        var data: NSMutableDictionary!
        
        #if DEBUG
            defaultUsername = String.UserDefaults.DebugUsername.rawValue
            defaultPassword = String.UserDefaults.DebugPassword.rawValue
        #else
            defaultUsername = String.UserDefaults.AdminUsername.rawValue
            defaultPassword = String.UserDefaults.AdminPassword.rawValue
        #endif
        
        // assign user if not already created
        self.user = user ?? appData.savedUser ?? User.init()
        
        // assign default values if all of the above values set give a null result
        if self.user.credentials == nil {
            if self.user.username == nil {
                self.user.username = defaultUsername
            }
            
            self.user.password = user.password ?? defaultPassword
        }
        
        if user != nil {
            if appData != nil {
                success = true
            } else {
                self.appData = AppData.init()
                success = true
            }
        } else {
            self.user = User(
                withUsername: String.UserDefaults.AdminUsername.rawValue,
                password: String.UserDefaults.AdminPassword.rawValue,
                isAdmin: true
            )
        }
        
        if self.user != nil && self.user.username != nil && self.user.password != nil {
            username = user.username
            password = user.password
        }
        
        username = username ?? user.username ?? defaultUsername
        password = password ?? user.password ?? defaultPassword
        
        
        // TODO remove this -> testing only--should go in other class
        data = [
            String.PlistDataTitles.Username.rawValue:username,
            String.PlistDataTitles.Password.rawValue:password
        ]
        // TODO TODO TODO TODO TODO TODO TODO
        
        /*
        var userFilesDir = String.Paths.UserFiles.rawValue
        FileManager.default.createDirectory(atPath: userFilesDir, withIntermediateDirectories: true, attributes: .)
        FileManager.default.createFile(atPath: String.Paths.UserFiles.rawValue, contents: data, attributes: nil)
 */
        
        if data.count == 0 {
            handler(success, NSError())
        }
        
        return data
    }
}


