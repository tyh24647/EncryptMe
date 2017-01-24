//
//  AppDelegate.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var user: User!
    var credentials: Credentials!
    var dataManager: FBDataManager!
    var appData: AppData!
    var loginManager: LoginManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // init data manager
        self.dataManager = FBDataManager()
        
        // pass data manager to the app data class to allow for retrieving the correct defaults
        self.appData =  AppData.init(withDataManager: dataManager)
        
        #if DEBUG
            user = User()
            user.username = String.UserDefaults.AdminUsername.rawValue
            user.password = String.UserDefaults.AdminPassword.rawValue
        #else
            if appData.userIsLoggedIn {
                user = appData.savedUser
            } else {
                user = User()
                if user.isAdmin {
                    user.username = String.UserDefaults.AdminUsername.rawValue
                    user.password = String.UserDefaults.AdminPassword.rawValue
                } else {
                    user.username = String.UserDefaults.DefaultUsername.rawValue
                    user.password = String.UserDefaults.DefaultPassword.rawValue
                }
            }
        #endif
        
        // generate credentials for the user
        self.credentials = Credentials(withUsername: self.user.username, password: self.user.password)
        
        // init login manager
        self.loginManager = LoginManager(withCredentials: self.credentials)
        loginManager.login()
        
        return true
    }
    
    func promptForLogin() -> Void {
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

