//
//  DefaultStringConstants.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

extension String {
    
    // Default strings for user data
    enum UserDefaults: String {
        #if DEBUG
            case DebugUsername = "debug"
            case DebugPassword = "debugMe+"
        #endif
        case AdminUsername = "admin"
        case AdminPassword = "1_Peter_4_10"
        case DefaultUsername = "default"
        case DefaultPassword = "test"
        case UserProfilePlistName = "user-profile"
        case UserTypeTitle = "user-type"
        case AdminTitle = "is-administrator"
        
        enum UserTypes: String {
            case Default = "Default"
            case Admin = "Admin"
            #if DEBUG
            case Debug = "Debug"
            #endif
        }
    }
    
    enum UserValidationMsgs: String {
        case LoginFailed = "Unable to log in user"
        case NoUserSetup = "No user account has been setup"
        case MissingUsername = "Missing username"
        case MissingPassword = "Missing password"
        case InvalidUsername = "Invalid username"
        case InvalidPassword = "Invalid password"
        #if DEBUG
            case Debug = "Validation overridden - debug mode enabled"
        #endif
        case Default = "No User Account Created"
    
        init() {
            self = .Default
        }
    }
    
    enum FileTypes: String {
        case Unknown = "Unknown"
        case PropertyList = ".plist"
        
        enum Video: String {
            case mp4 = ".mp4"
            case mov = ".mov"
            case avi = ".avi"
            case wmv = ".wmv"
        }
        
        enum Audio: String {
            case flac = ".flac"
            case aiff = ".aiff"
            case m4a = ".m4a"
            case wav = ".wav"
            case m4p = ".m4p"
            case wma = ".wma"
            case aac = ".aac"
            case mp3 = ".mp3"
        }
        
        enum Photo: String {
            case gif = ".gif"
            case png = ".png"
            case jpeg = ".jpg"
        }
        
        init() {
            self = .Unknown
        }
    }
    
    enum Identifiers: String {
        case DefaultId = "default"
        
        enum TableCell: String {
            case FBItemCellId = "fbCell"
            case SettingsCell = "settingsCell"
        }
        
        init() {
            self = .DefaultId
        }
    }
    
    enum Paths: String {
        case Default = "/"
        case UserFiles = "/Users/Files/Default/"
        case LogFilePath = "/Logs/"
    }
    
    enum Dispatch: String {
        case Background = "background_thread"
        case Default = "thread1"
        
        init() {
            self = .Default
        }
    }
    
    enum PlistDataTitles: String {
        case Username = "Username"
        case Password = "Password"
    }
    
    enum Plist: String {
        case Unknown = "An unknown error occurred creating plist file"
        case CompletingTask = "Completing property list file generation..."
        case Success = "User property list file generated successfully"
    }
    
    enum Exceptions: String {
        case DefaultException = "UnknownException"
        init() { self = .DefaultException }
        
        enum Names: String {
            case Default = "UnknownType"
            init() { self = .Default }
            
            enum LoginExceptions: String {
                case Default = "LoginException"
                case MissingUsername = "MissingUsernameException"
                case MissingPassword = "MissingPasswordException"
                case MissingEncryptionKey = "MissingEncryptionKeyException"
                case InvalidUsername = "InvalidUsernameException"
                case InvalidPassword = "InvalidPasswordException"
                case InvalidEncryptionKey = "InvalidEncryptionKeyException"
                init() { self = .Default }
            }
        }
        
        enum Reasons: String {
            case Default = "An unknown error has occurred"
            init() { self = .Default }
            
            enum LoginReasons: String {
                case DefaultReason = "No reason for the error is specified"
                case MissingUsername = "Username cannot be found"
                case MissingPassword = "Password cannot be found"
                case MissingEncryptionKey = "Encryption key cannot be found"
                case InvalidUsername = "Username is invalid"
                case InvalidPassword = "Password is invalid"
                case InvalidEncryptionKey = "Encryption key is invalid"
            }
        }
    }
}

