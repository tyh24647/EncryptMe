//
//  File.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

struct File {
    
    // MARK: - Constants
    
    let isDirectory, canParse, canOpenInEditor: Bool
    let directory, dateCreated: String
    let parentDirectory: String!
    let fileSize: Int
    
    // MARK: - Enums
    
    /// Possible file types handled by this application
    ///
    /// - Text: Text file
    /// - Video: Video file
    /// - Image: Image file
    /// - Directory: Folder
    /// - Other: Miscellanious/unspecified file or directory
    enum FileType: String {
        case Text, Video, Image, Directory, Other
    }
    
    /// Objects/parameters pertaining specifically to the date and its
    /// relation to the file object
    ///
    /// - DateCreated: The date the file was created
    /// - DateModified: The date the file was modified (if applicable)
    /// - DateAccessed: The date the file was most recently accessed
    enum Date: String {
        case DateCreated, DateModified, DateAccessed
    }
}
