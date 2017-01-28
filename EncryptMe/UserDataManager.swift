//
//  UserDataManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

open class UserDataManager {
    
    // MARK: Init Constants
    let kFileManager = FileManager.default
    
    // MARK: Init vars
    var shouldCreateUserPlist: Bool!
    var appDefaults: AppDefaults!
    var appData: AppData!
    var user: User!
    var userPlistPath: String!
    var userPlistData: NSMutableDictionary!
    
    
    // MARK: - Constructors
    
    ///
    /// Constructs a user data manager object without user or application
    /// data specifications
    ///
    init() {
        initDefaults()
    }
    
    /// Constructs a user data manager object with the specified application data
    ///
    /// - Parameter data: The app data to be used
    init(withData data: AppData!) {
        self.appData = data
        initDefaults()
    }
    
    /// Constructs a user data manager object with the specified user
    ///
    /// - Parameter user: The user in which the data will be saved for
    init(withUser user: User!) {
        self.user = user
        initDefaults()
    }
    
    /// Creates a plist file at the standard directory with the standard file name
    ///
    /// - Parameters:
    ///     - completion: The completion handler to ensure the method is executed
    ///     - success: whether the completion handler has finished successfully
    ///     - error: Error that occurred in the completion handler
    /// - Throws: error if the file cannot be generated
    /// - Returns: The debug description of the generated plist file
    func genrateUserPlistFile(withCompletion completion: (_ success: Bool, _ error: Error) -> Void) throws -> String {
        self.userPlistData = generatePlistDictData(completion: { success, err in
            Console.Err(errMsg: err.debugDescription)
            completion(success, err)
        })
        
        return userPlistData.debugDescription
    }
    
    /// Initializes the data manager defaults
    fileprivate func initDefaults() -> Void {
        let userProfilePlistName = String.FileTypes.PropertyList.rawValue
        
        self.shouldCreateUserPlist = true
        self.appDefaults = AppDefaults()
        self.userPlistPath = appDefaults.path.appending(userProfilePlistName)
        
        if !self.appDefaults.file.exists(userProfilePlistName) {
            Console.Debug(debugMsg: "Generating user property list file")
            
            // generate plist data
            self.userPlistData = generatePlistDictData(completion: { success, err in
                if success {
                    Console.Debug(debugMsg: "User property list file generated successfully".localized())
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
    
    /// Generates a property list file (*.plist) in which the user's saved data will be stored. If
    /// user data has been specified, the file will be initialized with those default values
    ///
    /// - Parameters:
    ///     - handler: The completion handler in which the process will continue until the task has finished executing
    ///     - success: Wthether or not the task has succeeded
    ///     - error: Any error that is thrown in the file creation process
    /// - Returns: NSMutableDictionary containing the new plist data
    fileprivate func generatePlistDictData(completion handler:(_ success: Bool, _ error: NSError) -> Void) -> NSMutableDictionary {
        var data: NSMutableDictionary!
        var defaultUsername: String!
        var defaultPassword: String!
        var username: String!
        var password: String!
        var success = false
        
        #if DEBUG
            defaultUsername = String.UserDefaults.DebugUsername.rawValue
            defaultPassword = String.UserDefaults.DebugPassword.rawValue
        #else
            defaultUsername = String.UserDefaults.AdminUsername.rawValue
            defaultPassword = String.UserDefaults.AdminPassword.rawValue
        #endif
        
        // assign user if not already created
        self.user = user ?? appData.savedUser ?? User()
        
        // assign default values if all of the above values set give a null result
        if self.user.credentials == nil {
            if self.user.username == nil {
                self.user.username = defaultUsername
            }
            
            self.user.password = user.password ?? defaultPassword
        }
        
        // ensure that the user is not nil and that everything has been initialized properly
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
        
        let usernameTitleKey = String.PlistDataTitles.Username.rawValue
        let passwordTitleKey = String.PlistDataTitles.Password.rawValue
        
        // init data
        data = NSMutableDictionary()
        
        // init data values
        data.setValue(username, forUndefinedKey: usernameTitleKey)
        data.setValue(password, forUndefinedKey: passwordTitleKey)
        
        let userFilesDir = String.Paths.UserFiles.rawValue
        
        // create directory for user plist file at the default path
        do {
            let filesDirURL = URL(fileURLWithPath: userFilesDir, isDirectory: true)
            try FileManager.default.createDirectory(at: filesDirURL, withIntermediateDirectories: true, attributes: .none)
        } catch {
            Console.Err(errMsg: error.localizedDescription)
        }
        
        // create user plist file if not already present
        let userPrefsFileTitle = String.UserDefaults.UserProfilePlistName.rawValue
        let fullPath = userFilesDir + userPrefsFileTitle
        let pathURL = URL(fileURLWithPath: fullPath)
        let dataData = NSKeyedArchiver.archivedData(withRootObject: data)
        
        // remove file and replace with updated info if already exists
        if FileManager.default.fileExists(atPath: userFilesDir + userPrefsFileTitle) {
            do {
                try kFileManager.removeItem(at: pathURL)
            } catch {
                Console.Err(errMsg: error.localizedDescription)
            }
        }
        
        // create plist file with replacement data
        kFileManager.createFile(atPath: fullPath, contents: dataData, attributes: .none)
        
        // throw error if still empty
        if data.count == 0 {
            handler(success, NSError())
        }
        
        return data
    }
}


