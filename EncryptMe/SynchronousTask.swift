//
//  SynchronousTask.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

protocol SynchronousTask {
    static func addTaskToSyncronousQueue(_ task: DispatchWorkItem, handler: (Bool, NSError?) -> Void)
    static func addTaskToSynchronousBackgroundThread(_ task: DispatchWorkItem, handler: (Bool, NSError?) -> Void)
}

extension DispatchQueue: SynchronousTask {
    open class func addTaskToSyncronousQueue(_ task: DispatchWorkItem, handler: (Bool, NSError?) -> Void) {
        var success = false
        DispatchQueue.main.sync(execute: task)
        success = true
        handler(success, nil)
    }
    
    open class func addTaskToSynchronousBackgroundThread(_ task: DispatchWorkItem, handler: (Bool, NSError?) -> Void) {
        var success = false
        let backgroundQueue = DispatchQueue(label: "background_task")
        backgroundQueue.sync(execute: task)
        success = true
        handler(success, nil)
    }
}
