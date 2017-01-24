//
//  File.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

struct File {
    enum FileType: String {
        case Text, Video, Image, Directory, Other
    }
    
    enum Date: String {
        case DateCreated, DateModified, DateAccessed
    }
    
    let isDirectory, canParse, canOpenInEditor: Bool
    let directory, dateCreated: String
    let parentDirectory: String!
    let fileSize: Int
}
