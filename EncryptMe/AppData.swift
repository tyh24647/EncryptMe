//
//  AppData.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

///
///
public class AppData {
    // global shared instance of this class to be used throughout the application
    static let sharedInstance = AppData()
    
    // init vars
    var userIsLoggedIn: Bool!
    var savedUser: User!
    var appDefaults: AppDefaults!
    
    // data manager object which cannot be null
    var dataManager: FBDataManager! {
        get {
            return self.dataManager ?? generateDataManager()
        } set {
            self.dataManager = newValue ?? generateDataManager()
        }
    }
    
    init() {
        self.appDefaults = generateAppDefaults()
        self.dataManager = generateDataManager()
        self.userIsLoggedIn = isLoggedIn()
    }
    
    init(withDataManager dataManager: FBDataManager!) {
        self.dataManager = dataManager ?? generateDataManager()
        self.userIsLoggedIn = isLoggedIn()
    }
    
    private func generateDataManager() -> FBDataManager {
        let dMgr = FBDataManager()
        dMgr.user = self.savedUser ?? User()
        
        return dMgr
    }
    
    fileprivate func generateAppDefaults() -> AppDefaults {
        var defaults: AppDefaults!
        
        // do any defaults setup here
        
        defaults = AppDefaults()
        // TODO: add more functionality
        
        return defaults
    }
    
    private func isLoggedIn() -> Bool {
        #if DEBUG
            self.savedUser = User()
            savedUser.username = String.UserDefaults.AdminUsername.rawValue
            savedUser.password = String.UserDefaults.AdminPassword.rawValue
            return true
        #else
        // TODO add functionality here
            return false
        #endif
    }
    
    static func hasSavedAppData() -> Bool {
        
        // TODO
        
        return false
    }
}
