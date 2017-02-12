//
//  AppDelegate.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var user: User!
    var credentials: Credentials!
    var dataManager: FBDataManager?
    var appData: AppData!
    var loginManager: LoginManager!
    var userDataManager: UserDataManager!
    var userPlistFile: PropertyListSerialization!
    var isAdmin = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // init data manager
        self.dataManager = FBDataManager()
        
        // pass data manager to the app data class to allow for retrieving the correct defaults
        self.appData =  AppData.init(withDataManager: dataManager)
        
        #if DEBUG
            user = User(debugMode: true)
            user.username = String.UserDefaults.DebugUsername.rawValue
            user.password = String.UserDefaults.DebugPassword.rawValue
            self.isAdmin = true
        #else
            if appData.userIsLoggedIn {
                user = appData.savedUser
            } else {
                user = User()
                if user.isAdmin {
                    user.username = String.UserDefaults.AdminUsername.rawValue
                    user.password = String.UserDefaults.AdminPassword.rawValue
                    self.isAdmin = true
                } else {
                    user.username = String.UserDefaults.DefaultUsername.rawValue
                    user.password = String.UserDefaults.DefaultPassword.rawValue
                    self.isAdmin = false
                }
            }
        #endif
        
        self.credentials = Credentials(withUsername: self.user.username, password: self.user.password)
        self.loginManager = LoginManager(withCredentials: credentials)
        self.user.isAdmin = true
        
        // log in the user
        var successfulLogin: Bool
        do {
            successfulLogin = try loginManager.login(withCompletion: { success, err in
                if err != nil && !success {
                    Console.Err(errMsg: err?.localizedDescription)
                }
                
                return success
            })
        } catch {
            successfulLogin = false
            var errMsg: String?
            if error.localizedDescription.isEmpty {
                errMsg = "Unable to log in user".localized()
                Console.Err(errMsg: errMsg)
            }
        }
        
        #if DEBUG
            if successfulLogin {
                Console.Debug(debugMsg: "User login successful".localized())
            } else {
                Console.Err(errMsg: "Unable to log in user".localized())
            }
        #endif
        
        // init user data manager
        self.userDataManager = UserDataManager()
        userDataManager.appData = self.appData
        
        var plistStr: String?
        do {    //                                                      <-- generate plist and set values
            plistStr = try userDataManager.genrateUserPlistFile(withCompletion: { success, err in
                if !err.localizedDescription.isEmpty {
                    do {    //                                          <-- Retry until completion
                        plistStr = try userDataManager.genrateUserPlistFile(withCompletion: { success, err in
                            // TODO: Add functionality in the completion handler
                        })
                    } catch {
                        Console.Err(errMsg: err.localizedDescription)
                    }
                }
                
                #if DEBUG
                    Console.Debug(
                        debugMsg: success && err.localizedDescription.isEmpty ?
                            String.Plist.Success.rawValue.localized() :
                            String.Plist.CompletingTask.rawValue.localized()
                    )
                #endif
            })
        } catch {
            let plistErrMsg = String(
                error.localizedDescription.isEmpty ?
                    String.Plist.Unknown.rawValue.localized() :
                    error.localizedDescription
            )
            
            Console.Err(errMsg: plistErrMsg ?? String.Plist.Unknown.rawValue)
        }
        
        if plistStr != nil {
            plistStr = String.Empty
            
            #if DEBUG
                Console.Debug(debugMsg: "User property list file: \(plistStr)")
            #endif
        }
        
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
        
        /*
        let saveUserPlistTask = DispatchWorkItem(qos: .userInitiated, flags: .assignCurrentContext, block: {
            do {
                try self.userPlistFile = self.userDataManager.genrateUserPlistFile(withCompletion: { success, err in
                    
                })
            } catch {
                //err =
            }
        })
        
        AsyncTask().addAsyncTaskToBackgroundThread(saveUserPlistTask)
 */
    }


}

