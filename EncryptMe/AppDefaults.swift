//
//  AppDefaults.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

private let kDocumentsArr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

struct AppDefaults {
    let kDocuments = kDocumentsArr
    let kDocumentsDirectory = kDocumentsArr[0]
    
    // tmp tmp tmp tmp tmp
    var file = File()
    // tmp tmp tmp tmp tmp
    
    enum DocumentPaths {
        case Default
        case Custom
    }
    
    var directory: String! {
        get {
            return self.directory ?? kDocumentsDirectory
        } set {
            self.directory = newValue ?? kDocumentsDirectory
        }
    }
    
    private var pathType: DocumentPaths!
    var path: String! {
        get {
            return self.path ?? kDocumentsDirectory
        } set {
            pathType = newValue ?? kDocumentsDirectory == kDocumentsDirectory ? .Default : .Custom
            self.path = newValue ?? kDocumentsDirectory
        }
    }
    
    struct File {
        let documents = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true
        )
        
        public func exists(_ searchItemFileName: String!) -> Bool {
            return documents.contains(searchItemFileName)
        }
    }
    
}


