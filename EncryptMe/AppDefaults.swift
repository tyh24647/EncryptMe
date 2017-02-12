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
    
    private var _dir: String!
    var directory: String! {
        get {
            return _dir ?? kDocumentsDirectory
        } set {
            _dir = newValue ?? kDocumentsDirectory
        }
    }
    
    private var pathType: DocumentPaths!
    var path: String!
    
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


