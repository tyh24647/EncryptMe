//
//  AsyncTask.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

protocol AsyncTask {
    static func addAsyncTaskToMainDispatchQueue(_ task: DispatchWorkItem) -> Void
    static func addAsyncTaskToBackgroundThread(_ task: DispatchWorkItem) -> Void
    static func addAsyncTaskWithCompletion(_ task: DispatchWorkItem, completion: (Bool, NSError?) -> Void)
}

extension DispatchQueue: AsyncTask {
    
    static func addAsyncTaskWithCompletion(_ task: DispatchWorkItem, completion: (Bool, NSError?) -> Void) {
        var success = false
        DispatchQueues.MainQueue.async {
            task.perform()
        }
        
        success = true
        completion(success, nil)
    }
    
    open class func addAsyncTaskToMainDispatchQueue(_ task: DispatchWorkItem) {
        DispatchQueues.MainQueue.async {
            task.perform()
        }
    }

    open class func addAsyncTaskToBackgroundThread(_ task: DispatchWorkItem) {
        DispatchQueues.BThread.async {
            task.perform()
        }
    }
}

