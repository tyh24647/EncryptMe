//
//  PlistManager.swift
//  PlistManagerExample
//
//  Created by Tyler hostager on 1/24/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

let plistFileName = String.UserDefaults.UserProfilePlistName.rawValue

struct Plist {
    
    // MARK: Enums
    
    /// Enumeration of property list errors
    ///
    /// - FileNotWritten: The file could not be written
    /// - FileDoesNotExist: The file does not exist
    enum PlistError: Error {
        case FileNotWritten
        case FileDoesNotExist
    }
    
    // MARK: Variables
    
    var name: String
    
    var sourcePath: String? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return .none }
        return path
    }
    
    var destPath: String? {
        guard sourcePath != .none else { return .none }
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (dir as NSString).appendingPathComponent("\(name).plist")
    }
    
    init?(name: String) {
        self.init(name: name)
        guard let source = self.sourcePath else { return nil }
        guard let destination = self.destPath else { return nil }
        
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: source) else { return nil }
        self.name = name
        
        if !fileManager.fileExists(atPath: destination) {
            do {
                try fileManager.copyItem(atPath: source, toPath: destination)
            } catch let error as NSError {
                Console.Err(errMsg: "[PlistManager] Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    /// Retrieves the data values from the property list
    ///
    /// - Returns: The data
    func getValuesInPlistFile() -> NSDictionary? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSDictionary(contentsOfFile: destPath!) else { return .none }
            return dict
        } else {
            return .none
        }
    }
    
    /// Retrieves the mutable property list
    ///
    /// - Returns: The property list
    func getMutablePlistFile() -> NSMutableDictionary? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSMutableDictionary(contentsOfFile: destPath!) else { return .none }
            return dict
        } else {
            return .none
        }
    }
    
    /// Adds the specified dictionary values to the property list
    ///
    /// - Parameter dictionary: The dictionary values to add
    /// - Throws: File not written or file does not exist
    func addValuesToPlistFile(dictionary: NSDictionary) throws {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            if !dictionary.write(toFile: destPath!, atomically: false) {
                Console.Err(errMsg: "[PlistManager] File not written successfully")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }
}

class PlistManager {
    static let sharedInstance = PlistManager()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    /// Initializes the plist manager
    func startPlistManager() {
        if let _ = Plist(name: plistFileName) {
            Console.Debug(debugMsg: "[PlistManager] PlistManager started")
        }
    }
    
    /// Adds a new item to the property list
    ///
    /// - Parameters:
    ///   - key: The key for the value
    ///   - value: The value for the key
    func addNewItemWithKey(key: String, value: AnyObject) {
        Console.Debug(debugMsg: "[PlistManager] Starting to add item for key '\(key) with value '\(value)' . . .")
        if !keyAlreadyExists(key: key) {
            if let plist = Plist(name: plistFileName) {
                let dict = plist.getMutablePlistFile()!
                dict[key] = value
                
                do {
                    try plist.addValuesToPlistFile(dictionary: dict)
                } catch {
                    Console.Err(errMsg: error.localizedDescription)
                }
                
                Console.Debug(debugMsg: "[PlistManager] An Action has been performed. You can check if it went ok by taking a look at the current content of the plist file: ")
                Console.Debug(debugMsg: "[PlistManager] \(plist.getValuesInPlistFile())")
            } else {
                Console.Err(errMsg: "[PlistManager] Unable to get Plist")
            }
        } else {
            Console.Err(errMsg: "[PlistManager] Item for key '\(key)' already exists. Not saving Item. Not overwriting value.")
        }
    }
    
    /// Removes the item with the specified key
    ///
    /// - Parameter key: The key of the item in which to remove
    func removeItemForKey(key: String) {
        Console.Debug(debugMsg: "[PlistManager] Starting to remove item for key '\(key) . . .")
        if keyAlreadyExists(key: key) {
            if let plist = Plist(name: plistFileName) {
                let dict = plist.getMutablePlistFile()!
                dict.removeObject(forKey: key)
                
                do {
                    try plist.addValuesToPlistFile(dictionary: dict)
                } catch {
                    Console.Err(errMsg: error.localizedDescription)
                }
                
                Console.Debug(debugMsg: "[PlistManager] An Action has been performed. You can check if it went ok by taking a look at the current content of the plist file: ")
                Console.Debug(debugMsg: "[PlistManager] \(plist.getValuesInPlistFile())")
            } else {
                Console.Err(errMsg: "[PlistManager] Unable to get Plist")
            }
        } else {
            Console.Err(errMsg: "[PlistManager] Item for key '\(key)' does not exists. Remove canceled.")
        }
        
    }
    
    /// Remove all dictionary items from the property list
    func removeAllItemsFromPlist() {
        if let plist = Plist(name: plistFileName) {
            let dict = plist.getMutablePlistFile()!
            let keys = Array(dict.allKeys)
            
            if keys.count != 0 {
                dict.removeAllObjects()
            } else {
                Console.Err(errMsg: "[PlistManager] Plist is already empty. Removal of all items canceled.")
            }
            
            do {
                try plist.addValuesToPlistFile(dictionary: dict)
            } catch {
                Console.Err(errMsg: error.localizedDescription)
            }
            
            Console.Debug(debugMsg: "[PlistManager] An Action has been performed. You can check if it went ok by taking a look at the current content of the plist file: ")
            Console.Debug(debugMsg: "[PlistManager] \(plist.getValuesInPlistFile())")
        } else {
            Console.Err(errMsg: "[PlistManager] Unable to get Plist")
        }
    }
    
    /// Saves the given value to a dictionary value with the specified key
    ///
    /// - Parameters:
    ///   - value: The value to assign
    ///   - forKey: The key to save the value for
    func saveValue(value: AnyObject, forKey: String) {
        if let plist = Plist(name: plistFileName) {
            let dict = plist.getMutablePlistFile()!
            
            if let dictValue = dict[forKey] {
                if type(of: value) != type(of: dictValue) {
                    Console.Debug(debugMsg: "[PlistManager] WARNING: You are saving a \(type(of: value)) typed value into a \(type(of: dictValue)) typed value. Best practice is to save Int values to Int fields, String values to String fields etc. (For example: '_NSContiguousString' to '__NSCFString' is ok too; they are both String types) If you believe that this mismatch in the types of the values is ok and will not break your code than disregard this message.")
                }
                
                dict[forKey] = value
            }
            
            do {
                try plist.addValuesToPlistFile(dictionary: dict)
            } catch {
                Console.Err(errMsg: error.localizedDescription)
            }
            
            Console.Debug(debugMsg: "[PlistManager] An Action has been performed. You can check if it went ok by taking a look at the current content of the plist file: ")
            Console.Debug(debugMsg: "[PlistManager] \(plist.getValuesInPlistFile())")
        } else {
            Console.Err(errMsg: "[PlistManager] Unable to get Plist")
        }
    }
    
    /// Retrieves the value from the property list for the specified key
    ///
    /// - Parameter key: The key for the value to return
    /// - Returns: The value of the object with the given key
    func getValueForKey(key: String) -> AnyObject? {
        var value:AnyObject?
        
        if let plist = Plist(name: plistFileName) {
            let dict = plist.getMutablePlistFile()!
            let keys = Array(dict.allKeys)
            Console.Debug(debugMsg: "[PlistManager] Keys are: \(keys)")
            
            if keys.count != 0 {
                for (_,element) in keys.enumerated() {
                    Console.Debug(debugMsg: "[PlistManager] Key Index - \(index) = \(element)")
                    if element as! String == key {
                        Console.Debug(debugMsg: "[PlistManager] Found the Item that we were looking for for key: [\(key)]")
                        value = dict[key]! as AnyObject?
                    } else {
                        Console.Err(errMsg: "[PlistManager] This is Item with key '\(element)' and not the Item that we are looking for with key: \(key)")
                    }
                }
                
                if value != nil {
                    Console.Debug(debugMsg: "[PlistManager] The Element that we were looking for exists: [\(key)]: \(value)")
                    return value!
                } else {
                    Console.Debug(debugMsg: "[PlistManager] WARNING: The Item for key '\(key)' does not exist! Please, check your spelling.")
                    return .none
                }
            } else {
                Console.Err(errMsg: "[PlistManager] No Plist Item Found when searching for item with key: \(key). The Plist is Empty!")
                return .none
            }
        } else {
            Console.Err(errMsg: "[PlistManager] Unable to get Plist")
            return .none
        }
    }
    
    /// Returns whether or not the key already exists in the property list
    ///
    /// - Parameter key: The key to search for
    /// - Returns: True if it exists, else false
    func keyAlreadyExists(key:String) -> Bool {
        var keyExists = false
        
        if let plist = Plist(name: plistFileName) {
            let dict = plist.getMutablePlistFile()!
            let keys = Array(dict.allKeys)
            
            Console.Debug(debugMsg: "[PlistManager] Keys are: \(keys)")
            
            if keys.count != 0 {
                for (_,element) in keys.enumerated() {
                    Console.Debug(debugMsg: "[PlistManager] Key Index - \(index) = \(element)")
                    if element as! String == key {
                        Console.Debug(debugMsg: "[PlistManager] Checked if item exists and found it for key: [\(key)]")
                        keyExists = true
                    } else {
                        Console.Err(errMsg: "[PlistManager] This is Element with key '\(element)' and not the Element that we are looking for with Key: \(key)")
                    }
                }
            } else {
                Console.Err(errMsg: "[PlistManager] No Plist Element Found with Key: \(key). The Plist is Empty!")
                keyExists =  false
            }
        } else {
            Console.Err(errMsg: "[PlistManager] Unable to get Plist")
            keyExists = false
        }
        
        return keyExists
    }
}


