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
    #endif
    static let adminUsername = String.UserDefaults.AdminUsername.rawValue
    static let adminPassword = String.UserDefaults.AdminPassword.rawValue
    static let defaultUsername = String.UserDefaults.AdminUsername.rawValue
    static let defaultPassword = String.UserDefaults.AdminPassword.rawValue
    
    
    // MARK: - Enums
    
    /// Enumeration of the different types of possible users
    ///
    /// - Admin: An administrative role
    /// - Debug: A debugging role (an admin)
    /// - Default: A standard user without admin privelages
    enum UserType {
        case Debug
        case Admin
        case Default
    }
    
    // MARK: - Init vars
    private var _userType: UserType = .Default
    var userType: UserType! {
        get {
            return _userType
        } set {
            _userType = newValue ?? .Default
        }
    }
    
    var hasFullPermissions: Bool! {
        get {
            return isDebug || isAdmin
        }
    }
    
    private var isDebug: Bool {
        get {
            return self.userType == .Debug
        }
    }
    
    private var _hasReadPermissions: Bool = true
    var hasReadPermissions: Bool {
        get {
            return _hasReadPermissions
        } set {
            var canRead: Bool = true // user should be able to read files by default(without encryption)
            
            #if DEBUG
                // be able to read by default
                canRead = newValue
            #else
                if isAdmin && !hasDefaultPermissions {
                    canRead = newValue  // admin - disable reading w/o encryption
                } else {
                    canRead = true      // no encryption unless set up with account
                }
            #endif
            
            _hasReadPermissions = canRead
        }
    }
    
    private var _hasWritePermissions: Bool = false  // disable writing by default without encryption
    var hasWritePermissions: Bool {
        get {
            return _hasWritePermissions
        } set {
            _hasWritePermissions = hasFullPermissions && self.isValidated ? isDebug : false
        }
    }
    
    private var _hasDefaultPermissions: Bool = true
    var hasDefaultPermissions: Bool {
        get {
            return _hasDefaultPermissions
        } set {
            let defaultPermissions = true
            let adminPermissions = false
            
            _hasDefaultPermissions = isAdmin ? newValue != adminPermissions ? newValue : adminPermissions : defaultPermissions
        }
    }
    
    // the separate getter and setter ensures the validation process is checked before proceeding
    private var _isAdmin: Bool!
    var isAdmin: Bool {
        get {
            validateUserAccount()
            if _isAdmin == nil {
                switch self.userType as UserType {
                case .Debug:
                    return true
                case .Admin:
                    return true
                default:
                    return false
                }
            }
            
            return _isAdmin
        } set {
            validateUserAccount()
            _isAdmin = newValue
        }
    }
    
    
    var hasSavedPrefsData: Bool {
        get {
            let pName = String.UserDefaults.UserProfilePlistName.rawValue
            
            // load saved preferences
            if userType == .Admin || userType == .Debug {
                return FileManager.default.fileExists(atPath: (FileManager.default.urls(
                    for: .documentDirectory,
                    in: .userDomainMask)[0]).appendingPathComponent(pName).absoluteString
                )
            }
            
            // default user can't have saved preferences
            return false
        }
    }
    
    // Mark: optional vars
    var username: String!
    var password: String!
    
    // MARK: Required vars
    var credentials: Credentials!
    var isValidated = false
    
    // MARK: - Constructors
    
    /// Default constructor
    init() {
        self.username = String.UserDefaults.DefaultUsername.rawValue
        self.password = String.UserDefaults.DefaultPassword.rawValue
        self.credentials = Credentials.init(withUsername: username, password: password)
        self.hasReadPermissions = true
        self.hasWritePermissions = false
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
        self.username = String.UserDefaults.DefaultUsername.rawValue
        self.password = String.UserDefaults.DefaultPassword.rawValue
        self.credentials = Credentials.init(withUsername: username, password: password)
        self.userType = .Debug
        self.isValidated = true     // debug mode automatically activated
        self.hasWritePermissions = true
    }
#endif
    
    /// Creates a default user object, when applicable
    func initDefaultUser() -> Void {
        self.username = String.UserDefaults.DefaultUsername.rawValue
        self.password = String.UserDefaults.DefaultPassword.rawValue
        self.credentials = Credentials.init(withUsername: username, password: password)
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
        #if DEBUG
            self.userType = .Debug
        #else
            self.userType = isAdmin ? .Admin : .Default
        #endif
        
        self.username = username ?? (
            self.isDebug ? User.debugUsername : (
                isAdmin ? User.adminUsername : User.defaultUsername
            )
        )
        
        self.password = password ?? (
            self.isDebug ? User.debugPassword : (
                isAdmin ? User.adminPassword : User.defaultPassword
            )
        )
        
        // init credentials
        self.credentials = Credentials.init(
            withUsername: self.username,
            password: self.password
        )
    }
    
    /// Ensures that the user account is valid, and fixes it if not
    fileprivate func validateUserAccount() -> Void {
        /*
            TODO: add account validation procedures here
                * READ PLIST FILE TO CHECK FOR POSSIBLE ENTRIES
 */
        self.isValidated = true
    }
    
    /// Checks to see if the user is currently logged in
    ///
    /// - Returns: Whether or not the user is logged in
    fileprivate func isLoggedIn() -> Bool {
        return username != nil && password != nil && userType != nil
    }
    
    public func allAttributes() -> String {
        let kUsernameTitle = String.PlistDataTitles.Username.rawValue
        let kPasswordTitle = String.PlistDataTitles.Password.rawValue
        let kDefaultUsername = String.UserDefaults.DefaultUsername.rawValue
        let kDefaultPassword = String.UserDefaults.DefaultPassword.rawValue
        let kDefault = String.UserDefaults.UserTypes.Default.rawValue
        let kAdmin = String.UserDefaults.UserTypes.Admin.rawValue
        let kDebug = String.UserDefaults.UserTypes.Debug.rawValue
        let uTypeTitle = String.UserDefaults.UserTypeTitle.rawValue
        let uType = userType == .Default ? kDefault : userType == .Admin ? kAdmin : kDebug
        let uAdminTitle = String.UserDefaults.AdminTitle.rawValue
        let uAdmin = self.isAdmin
        
        // create object dictionary
        var valuesDict: [String:String]!
        valuesDict[kUsernameTitle] = valuesDict[kUsernameTitle] == nil ?
            self.username ?? kDefaultUsername : valuesDict[kUsernameTitle]
        valuesDict[kPasswordTitle] = valuesDict[kPasswordTitle] == nil ?
            self.password ?? kDefaultPassword : valuesDict[kPasswordTitle]
        valuesDict[uTypeTitle] = uType
        valuesDict[uAdminTitle] = uAdmin.description
        return valuesDict.debugDescription
    }
}


