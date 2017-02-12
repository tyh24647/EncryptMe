//
//  EncryptionProtocol.swift
//  EncryptMe
//
//  Created by Tyler hostager on 1/28/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation
import Security

protocol EncryptionProtocol {
    init()  // initializer
    
    // MARK: Functions
    func encryptedData(forObject object: Any!, withClassType: AnyClass!) -> Data?
    func encryptedData(forObject object: Any!, withClassType: AnyClass!) -> UInt8?
    func decryptedData(forObjectNamed objectName: String!) -> Data?
    func decryptedData(forObjectNamed objectName: String!) -> UInt8?
    func generateCipher() -> String!
    func generateKey() -> String!
    func getData(forString string: String!) -> Data!
    func getData(forObject object: Any!) -> Data!
    func getUInt8Data(forString string: String!) -> UInt8!
    func getUInt8Data(forObject object: Any!) -> UInt8!
    func encrypt(withSecretKeyData keyData: UInt8!, object: AnyObject!)
    func encrypt(withSecretKeyData keyData: Data!, object: AnyObject!)
    func encrypt(withSecretKeyStr str: String!, object: AnyObject!)
    func encrypt(withSecretKeyStr str: String!, text: String!)
}
