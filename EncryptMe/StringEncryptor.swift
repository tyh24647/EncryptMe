//
//  CredentialsManager.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/28/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation
import Security

open class StringEncryptor: EncryptionProtocol {
    public static let currentInstance = StringEncryptor()
    
    var plainTxt: String!
    
    var plainTxtData: [UInt8]! {
        get {
            return [UInt8](self.plainTxt.utf8)
        }
    }
    
    var plainTxtDataLength: Int! {
        get {
            if self.plainTxt != nil && self.plainTxtData != nil {
                return self.plainTxtData.count
            }
            
            return nil
        }
    }
    
    
    required public init() {
        
    }
    
    convenience init(withText str: String!) {
        self.init()
        self.plainTxt = str
    }
    
    var encryptionKey: String! {
        get {
            return self.encryptionKey ?? generateDefaultEncryptionKey()
        }
    }
    
    
    public func generateDefaultEncryptionKey() -> String! {
        if plainTxt != nil {
            
        }
        
        return nil
    }
    
    public func generateKey(forString string: String!) -> String! {
        return nil
        // TODO
    }
    
    
    // MARK: Inherited methods
    func generateKey() -> String! {
        return nil
    }
    
    func generateCipher() -> String! {
        return nil
    }
    
    func getData(forObject object: Any!) -> Data! {
        return nil
    }
    
    func getData(forString string: String!) -> Data! {
        return nil
    }
    
    func getUInt8Data(forObject object: Any!) -> UInt8! {
        return nil
    }
    
    func getUInt8Data(forString string: String!) -> UInt8! {
        return nil
    }
    
    func decryptedData(forObjectNamed objectName: String!) -> Data? {
        return nil
    }
    
    func decryptedData(forObjectNamed objectName: String!) -> UInt8? {
        return nil
    }
    
    func encryptedData(forObject object: Any!, withClassType: AnyClass!) -> Data? {
        return nil
    }
    
    func encryptedData(forObject object: Any!, withClassType: AnyClass!) -> UInt8? {
        return nil
    }
    
    func encrypt(withSecretKeyStr str: String!, text: String!) {
        // TODO
    }
    
    func encrypt(withSecretKeyStr str: String!, object: AnyObject!) {
        // TODO
    }
    
    func encrypt(withSecretKeyData keyData: Data!, object: AnyObject!) {
        // TODO
    }
    
    func encrypt(withSecretKeyData keyData: UInt8!, object: AnyObject!) {
        // TODO
    }
}
