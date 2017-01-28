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
    
    /// Default constructor
    init() {
        self.docDirectoryPath = kDefaultFilePath
        self.path = kDefaultFilePath
        self.type = self.hasFileExtension(path) ? fileTypeForDirectoryElement(path) : kUnknownFileType
        self.name = kUnknownName
    }
    
    /// Constructs an FBItem object with the specified type
    ///
    /// - Parameter type: The type of the object in which to be constructed
    init(withType type: String!) {
        self.path = kDefaultFilePath
        self.type = type ?? (self.hasFileExtension(path) ? fileTypeForDirectoryElement(path) : kUnknownFileType)
        self.name = kUnknownName
    }
    
    
    /// Initializes the specific file item that has the specified type, path, name, and 
    /// whether or not the file item is a directory
    ///
    /// - Parameters:
    ///   - type: The type of file to create
    ///   - atPath: The desired path of the new item
    ///   - name: The name of the item
    ///   - isDirectory: Whether or not it should be a directory
    fileprivate func initFileItem(withType type: String!, atPath: String!, name: String!, isDirectory: Bool) -> Void {
        
    }
    
    
    /// Determines whether or not the FBItem has a file extension associated with it
    ///
    /// - Parameter path: The path to check
    /// - Returns: True if it has an extension, else false
    fileprivate func hasFileExtension(_ path: String) -> Bool {
        let prefsPath = docDirectoryPath.appending("/user-profile.plist")
        var hasExtension = true
        
        // TODO add checking for extensions

        
        return hasExtension
    }
    
    /// Retrieves the file type of the file at the specified path
    ///
    /// - Parameter path: The path of the file to find
    /// - Returns: The type of file at the requested path
    fileprivate func fileTypeForDirectoryElement(_ path: String) -> String! {
        var fileType: String!
        
        return fileType
    }
}


