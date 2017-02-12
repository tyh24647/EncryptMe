//
//  LoginManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/23/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

class LoginManager {
    var credentials: Credentials!
    var username: String!
    var password: String!
    var loggedIn: Bool!
    
    init() {
        #if DEBUG
            self.username = String.UserDefaults.DebugUsername.rawValue
            self.password = String.UserDefaults.DebugPassword.rawValue
        #else
            self.username = String.UserDefaults.DefaultUsername.rawValue
            self.loggedIn = makeLoginAttempt()
        #endif
    }
    
    init(withCredentials credentials: Credentials!) {
        self.credentials = credentials ?? Credentials(withUsername: username, password: password)
        self.username = self.credentials.username
        self.password = self.credentials.password
        self.loggedIn = false
    }
    
    func login(withCompletion handler:(_ success: Bool, _ error: NSError?) -> Bool) throws -> Bool {
        var loginSuccess = false
        do {
            if try makeLoginAttempt() != nil {
                loginSuccess = try makeLoginAttempt()
            } else {
                throw NSException(name: NSExceptionName("loginError"), reason: "asdf", userInfo: .none) as! Error
            }
        } catch {
            Console.Err(errMsg: error.localizedDescription)
        }
        
        //do {
        /*
            let loginSuccess = login { try ((_ success: Bool, _ error: NSError?) -> Bool) throws -> Bool in {
                if error != nil {
                    
                }
                throw error
                
                var bingo = false
                
                bingo = try makeLoginAttempt()
                
             
                
                return success
                }
            }
 */
         //   throw NSException(name: "", reason: "", userInfo: .none) as! NSError
        //} catch {
            
        //}
        
        /*
        loginSuccess = try login { ss, err in
            var bingo = false
            
            bingo = makeLoginAttempt()
            
            if !bingo {
                throw err
            } else {
                return bingo
            }
        }
 */
        /*
        do {
            
            
            // TODO: add list of saved users -- check for user in saved data
            loginSuccess = try handler(true, nil)
            
            if !loginSuccess {
                throw NSException(name: NSExceptionName(String.Exceptions.Names.LoginExceptions.Default.rawValue), reason: String.Exceptions.Reasons.LoginReasons.DefaultReason.rawValue, userInfo: .none) as! NSError
            }
        } catch {
            //handler(loginSuccess, error as NSError?)
            Console.Err(errMsg: error.localizedDescription)
        }
        
        if !loginSuccess {
            let exName = NSExceptionName(String.Exceptions.Names.LoginExceptions.Default.rawValue)
            let exReason = String.Exceptions.Reasons.LoginReasons.DefaultReason.rawValue
            
            let ex = {
                return NSException(
                    name: exName,
                    reason: exReason,
                    userInfo: .none
                )
            }
         
            throw ex() as! NSError
        }
        
        return loginSuccess
 */
        
        return loginSuccess
    }
    
    fileprivate func makeLoginAttempt() throws -> Bool! {
        
        
        // TODO: TEST TEST TEST TEST TEST TEST TEST TEST TEST
        
        
        var success = false
        var userIsInDatabase: Bool = false
        
        if !userIsInDatabase {
            Console.Debug(debugMsg: "User is in database!")
            userIsInDatabase = true
        } else {
            throw NSException(name: NSExceptionName("ERROR"), reason: "can't locate user", userInfo: .none) as! NSError
        }
        
        
        if !success {
            success = true
        }
        
        
        // TODO: TEST TEST TEST TEST TEST TEST TEST TEST TEST
        
        
    //fileprivate func makeLoginAttempt(completion: (_ inner: () throws -> NSDictionary) -> Void) -> Bool {
    
        /*
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { response, data, error -> Void in
            
        }
        
        var success: Bool
       
        guard let
        
        // TODO: make methods to log in
        success = true
        
        if !success {
            
        }
 */
 
        return success
    }
}



