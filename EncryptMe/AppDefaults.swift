//
//  AppDefaults.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

struct AppDefaults {
    let kDefaultDocDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    enum DocumentPaths {
        case Default
        case Custom
    }
    
    var directory: String! {
        get {
            return self.directory ?? kDefaultDocDirPath
        } set {
            self.directory = newValue ?? kDefaultDocDirPath
        }
    }
    
    private var pathType: DocumentPaths!
    var path: String! {
        get {
            return self.path ?? kDefaultDocDirPath
        } set {
            pathType = newValue ?? kDefaultDocDirPath == kDefaultDocDirPath ? .Default : .Custom
            self.path = newValue ?? kDefaultDocDirPath
        }
    }
    
    
}


