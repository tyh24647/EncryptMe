//
//  DispatchQueues.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

struct DispatchQueues {
    
    // primary dispatch queue
    static let MainQueue: DispatchQueue = DispatchQueue.main
    
    // background thread for async tasks
    static let BThread: DispatchQueue = DispatchQueue(label: String.Dispatch.Background.rawValue)
    
    // TODO: add more functionality here
}

