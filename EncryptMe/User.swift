//
//  UserFileModel.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class User {
    
    // MARK: - Init constants
    #if DEBUG
    static let debugUsername = String.UserDefaults.DebugUsername.rawValue
    static let debugPassword = String.UserDefaults.DebugPassword.rawValue
    #else
    static let adminUsername = String.UserDefaults.AdminUsername.rawValue
    static let adminPassword = String.UserDefaults.AdminPassword.rawValue
    static let defaultUsername = String.UserDefaults.AdminUsername.rawValue
    static let defaultPassword = String.UserDefaults.AdminPassword.rawValue
    #endif
    
    // MARK: - Init vars
    var username: String!
    var password: String!
    var hasReadPermissions: Bool!
    var hasWritePermissions: Bool!
    var hasDefaultPermissions: Bool!
    var credentials: Credentials!
    
    // MARK - Init private vars
    private var isAdmin: Bool
    
    #if DEBUG
    
    private var isDebug: Bool! {
        get {
            switch self.userType as UserType {
            case .Debug:
                return true
            case .Admin:
                return false
            default:
                return false
            }
        }
    }
    #endif
    
    var userType: UserType! {
        get {
            return self.userType ?? .Default
        } set {
            self.userType = newValue ?? .Default
        }
    }
    
    var hasSavedPrefsData: Bool! {
        get {
            return self.hasSavedPrefsData
        } set {
            self.hasSavedPrefsData = newValue
        }
    }
    
    var hasFullPermissions: Bool! {
        get {
            return isAdmin || isDebug
        } set {
            self.hasFullPermissions = isAdmin || isDebug ? true : newValue
        }
    }
    
    // MARK: - Enums
    
    
    /// Enumeration of the different types of possible users
    ///
    /// - Admin: An administrative role
    /// - Debug: A debugging role (an admin)
    /// - Default: A standard user without admin privelages
    enum UserType {
        case Admin
        #if DEBUG
        case Debug
        #endif
        case Default
        
        init() {
            self = .Default
        }
    }
    
    // MARK: - Constructors
    
    /// Default constructor
    init() {
        self.username = String.UserDefaults.DefaultUsername.rawValue
        self.password = String.UserDefaults.DefaultPassword.rawValue
        self.credentials = Credentials.init(withUsername: username, password: password)
        self.isAdmin = false
        self.userType = .Default
        validateUserAccount()
    }
    
    /// Constructs a user object with the specified username and password.
    ///
    /// - Parameters:
    ///   - username: The username to assign
    ///   - password: The password to assign
    convenience init(withUsername username: String, password: String) {
        self.init()
        createUser(withUsername: username, password: password, isAdmin: true)
        validateUserAccount()
    }
    
    /// Constructs a user object with the specified username, 
    /// password, and admin permissions.
    ///
    /// - Parameters:
    ///   - username:   The username to assign
    ///   - password:   The password to assign
    ///   - isAdmin:    Whether or not the user has administrative privelages
    convenience init(withUsername username: String, password: String, isAdmin: Bool) {
        self.init()
        createUser(withUsername: username, password: password, isAdmin: isAdmin)
        validateUserAccount()
    }
    
#if DEBUG
    /// Constructs a user object with the specified parameters that pertain
    /// only to debug mode, if enabled.
    ///
    /// - Parameter enabled: Whether or not debug mode is enabled
    init(debugMode enabled: Bool) {
        self.username = String.UserDefaults.AdminUsername.rawValue
        self.password = String.UserDefaults.AdminPassword.rawValue
        self.credentials = Credentials.init(withUsername: username, password: password)
        self.isAdmin = true
        self.userType = .Debug
    }
#endif
    
    /// Creates a default user object, when applicable
    func initDefaultUser() -> Void {
        self.username = String.UserDefaults.DefaultUsername.rawValue
        self.password = String.UserDefaults.DefaultPassword.rawValue
        self.credentials = Credentials.init(withUsername: username, password: password)
        self.isAdmin = false
        self.userType = .Default
    }
    
    /// Determines if the user is an administrator or not
    ///
    /// - Returns: True if admin, else false
    func isAdminAccount() -> Bool {
        validateUserAccount()
        
        // TODO: fill in method
        
        return true
    }
    
    /// Determines whether or not the program is currently debugging
    ///
    /// - Returns: True if currently debugging, else false
    func isDebugging() -> Bool {
        return self.isDebug
    }
    
    /// Creates a new user object with the specified username, password, and admin permissions
    ///
    /// - Parameters:
    ///   - username: The username of the user to be created
    ///   - password: The password of the user to be created
    ///   - isAdmin: Whether or not the new user should be an administrator
    fileprivate func createUser(withUsername username: String!, password: String!, isAdmin: Bool) -> Void {
        self.isAdmin = isAdmin
        #if DEBUG
            self.username = String.UserDefaults.DebugUsername.rawValue
            self.password = String.UserDefaults.DebugPassword.rawValue
            self.userType = .Debug
        #else
            if isAdmin {
                self.username = username ?? String.UserDefaults.AdminUsername.rawValue
                self.password = password ?? String.UserDefaults.AdminPassword.rawValue
                self.userType = .Admin
            } else {
                self.username = username ?? String.UserDefaults.DefaultUsername.rawValue
                self.password = password ?? String.UserDefaults.DefaultPassword.rawValue
                self.userType = .Default
            }
        #endif
        
        // init credentials
        self.credentials = Credentials.init(withUsername: self.username, password: self.password)
    }
    
    /// Ensures that the user account is valid, and fixes it if not
    fileprivate func validateUserAccount() -> Void {
        
    }
    
    /// Checks to see if the user is currently logged in
    ///
    /// - Returns: Whether or not the user is logged in
    fileprivate func isLoggedIn() -> Bool {
        var isLoggedIn = false
        
        //if AppData.sharedInstance.dataManager.user.isSaved
        
        return isLoggedIn
    }
}





/*
struct User {
    enum Info: String {
        case Username, Password
    }
    
    let canDecrypt, canEdit, canCreate, canRemove, canParse, canOpenInEditor: Bool
    let directory, dateCreated: String
    let parentDirectory: String!
    let fileSize: Int
}
*/
