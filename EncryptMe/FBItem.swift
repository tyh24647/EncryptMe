//
//  DirectoryItem.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

struct FBItem {
    
    // init constants
    let kUnknownFileType = String.FileTypes.Unknown.rawValue
    let kDefaultFilePath = String.Paths.Default.rawValue
    let kUnknownName = String.FileTypes.Unknown.rawValue
    
    // init vars
    var docDirectoryPath: String!
    var isDirectory: Bool!
    var name: String!
    var path: String!
    var type: String! {
        get {
            return self.type ?? kUnknownFileType
        } set {
            self.type = newValue ?? kUnknownFileType
        }
    }
    
    init() {
        self.docDirectoryPath = kDefaultFilePath
        self.path = kDefaultFilePath
        self.type = self.hasFileExtension(path) ? fileTypeForDirectoryElement(path) : kUnknownFileType
        self.name = kUnknownName
        #if DEBUG
            
        #else
        #endif
    }
    
    init(withType type: String!) {
        self.type = type
        
        self.path = kDefaultFilePath
        self.name = kUnknownName
        
        
    }
    
    fileprivate func initFileItem(withType type: String!, atPath: String!, name: String!, isDirectory: Bool) -> Void {
        
    }
    
    fileprivate func hasFileExtension(_ path: String) -> Bool {
        let prefsPath = docDirectoryPath.appending("/user-profile.plist")
        var hasExtension = true
        
        // TODO add checking for extensions

        
        return hasExtension
    }
    
    fileprivate func fileTypeForDirectoryElement(_ path: String) -> String! {
        var fileType: String!
        
        return fileType
    }
    
    
}


