//
//  Console.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

protocol Log {
    static func Log(debugMsg msg: String!)
    static func Log(debugMsg msg: String!, withTitle title: String!)
    static func Err(errMsg msg: String!)
    static func Err(errMsg msg: String!, withErrMsg errMsg: String!)
}

extension Console: Log {
    
    convenience init() {
        do {
            generateLogFileFolder()
            try FileManager.default.createDirectory(atPath: self.logFilePath, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
    open class func Log(debugMsg msg: String!) -> Void {
        stdLog(msg)
    }
    
    open class func Log(debugMsg msg: String!, withTitle title: String!) -> Void {
        stdLog(msg, title)
    }
    
    open class func Err(errMsg: String!) -> Void {
        errLog(errMsg)
    }
    
    open class func Err(errMsg: String!, withErrMsg errTitle: String!) -> Void {
        errLog(errMsg, errTitle)
    }
    
    private func writeToLogFile(_ msg: String!) -> Void {
        
        // TODO write logs to log file
        
    }
    
    
}

public class Console {
    private var documents: [String]!
    private var documentsDirectory: AnyObject
    var logFilePath: String!
    
    init(withLogFilePath logFilePath: String!) {
        // do nothing for now
    }
    
    fileprivate func generateLogFileFolder() -> Void {
        self.documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        self.documentsDirectory = documents[0] as AnyObject
        self.logFilePath = documentsDirectory.appendingPathComponent("Logs")
    }
    
    fileprivate static func stdLog(_ msg: String!) -> Void {
        if msg.characters.count > 0 {
            #if DEBUG
                debugPrint("> \(msg)")
            #else
                print("> \(msg)")
            #endif
        }
    }
    
    fileprivate static func stdLog(_ msg: String!, _ title: String!) -> Void {
        if title == nil || title.characters.count <= 0 {
            if msg != nil && msg.characters.count > 0 {
                stdLog(msg)
            }
        } else {
            #if DEBUG
                debugPrint("> \(title): \(msg)")
            #else
                print("> \(title): \(msg)")
            #endif
        }
    }
    
    fileprivate static func errLog(_ msg: String!) -> Void {
        if msg.characters.count > 0 {
            #if DEBUG
                debugPrint("> ERROR: \(msg)")
            #else
                print("> ERROR: \(msg)")
            #endif
        }
    }
    
    fileprivate static func errLog(_ errMsg: String!, _ errTitle: String!) -> Void {
        if errTitle == nil || errTitle.characters.count <= 0 {
            if errMsg != nil && errMsg.characters.count > 0 {
                errLog(errMsg)
            }
        } else {
            #if DEBUG
                debugPrint("> ERROR: \(errMsg)")
            #else
                print("> ERROR: \(errTitle): \(errMsg)")
            #endif
        }
    }
}

