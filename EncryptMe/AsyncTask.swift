//
//  AsyncTask.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

protocol AsyncTask {
    
    /// <#Description#>
    ///
    /// - Parameter task: <#task description#>
    /// - Returns: <#return value description#>
    static func addAsyncTaskToMainDispatchQueue(_ task: DispatchWorkItem) -> Void
    
    /// <#Description#>
    ///
    /// - Parameter task: <#task description#>
    /// - Returns: <#return value description#>
    static func addAsyncTaskToBackgroundThread(_ task: DispatchWorkItem) -> Void
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - task: <#task description#>
    ///   - completion: <#completion description#>
    static func addAsyncTaskWithCompletion(_ task: DispatchWorkItem, completion: (Bool, NSError?) -> Void)
}

extension DispatchQueue: AsyncTask {
    
    /// Adds an asynchronous task to the dispatch queue protocol with the completion handler
    ///
    /// - Parameters:
    ///   - task: The task in which to execute asynchronously
    ///   - completion: The completion handler
    static func addAsyncTaskWithCompletion(_ task: DispatchWorkItem, completion: (Bool, NSError?) -> Void) {
        var success = false
        DispatchQueues.MainQueue.async {
            task.perform()
        }
        
        success = true
        completion(success, nil)
    }
    
    /// Adds an async task to the primary dispatch queue
    ///
    /// - Parameter task: The task to add to main dispatch
    open class func addAsyncTaskToMainDispatchQueue(_ task: DispatchWorkItem) {
        DispatchQueues.MainQueue.async {
            task.perform()
        }
    }

    /// Adds an async task to a background thread
    ///
    /// - Parameter task: The task to add
    open class func addAsyncTaskToBackgroundThread(_ task: DispatchWorkItem) {
        DispatchQueues.BThread.async {
            task.perform()
        }
    }
}

