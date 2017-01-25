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
    }
    
    enum UserValidationMsgs: String {
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
        
        
        // TODO Test Test Test Test Test Test
        case LogFilePath = "/Logs/"
        // TODO Test Test Test Test Test Test
        
        
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
    
    
    
}

