//
//  UIDevice+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/16.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIDevice {
    
    static var isIPhone4:   Bool { return Int(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) == 480 }
    static var isIPhone5:   Bool { return Int(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) == 568 }
    static var isIphone6:   Bool { return Int(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) == 667 }
    static var isIphone6p:  Bool { return Int(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) == 736 }
    static var isIPhoneX:   Bool { return Int(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) == 812 }
    static var isIPhoneMX:  Bool { return Int(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) == 896 }
    static var isXGroup:    Bool { return isIPhoneX || isIPhoneMX }
}


private let _random_resource_: [String] = ["A", "B", "C", "D", "E", "F",
                                           "G", "H", "I", "J", "K", "L",
                                           "M", "N", "O", "P", "Q", "R",
                                           "S", "T", "U", "V", "W", "X",
                                           "Y", "Z", "1", "2", "3", "4",
                                           "5", "6", "7", "8", "9", "0"]

private let uuidKeychainKey: String = "UUID"

public extension SDExtension where T: UIDevice {
    
    /// UUID, 如果没获取到identifierForVendor.uuidString就自己生成一个
    var uuid: String {
        if let keychainedId = getKeychainedUUID() {
            return keychainedId
        }
        if let storeId = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? String {
            setKeychainUUID(storeId)
            return storeId
        }
        let newId = UIDevice.current.identifierForVendor?.uuidString ?? random()
        setKeychainUUID(newId)
        NSKeyedArchiver.archiveRootObject(newId, toFile: filePath)
        return newId
    }
    
    private func getKeychainedUUID() -> String? {
        let keychain = KeychainSwift()
        if let idPrefix = Bundle.main.object(forInfoDictionaryKey: "AppIdentifierPrefix") as? String {
            keychain.accessGroup = idPrefix + ".putao"
        } else {
            keychain.accessGroup = "com.putao"
        }
        guard
            let data = keychain.getData(uuidKeychainKey),
            let id = String(data: data, encoding: .utf8)
            else { return nil }
        return id
    }
    
    private func setKeychainUUID(_ id: String?) {
        guard let `id` = id, let data = id.data(using: .utf8) else { return }
        let keychain = KeychainSwift()
        if let idPrefix = Bundle.main.object(forInfoDictionaryKey: "AppIdentifierPrefix") as? String {
            keychain.accessGroup = idPrefix + ".putao"
        } else {
            keychain.accessGroup = "com.putao"
        }
        keychain.set(data, forKey: uuidKeychainKey)
    }
    
    /// deviceUUID.data 不要修改，否则更新会丢失原有UUID
    private var filePath: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first else {
            return NSHomeDirectory().sd.appendingPathComponent("Library/deviceUUID.data")
        }
        return path.sd.appendingPathComponent("deviceUUID.data")
    }
    
    private func random() -> String {
        let components = [randomWords(8), randomWords(4), randomWords(4), randomWords(4), randomWords(12)]
        return components.joined(separator: "-").uppercased()
    }
    
    private func randomWords(_ count: Int) -> String {
        var res: [String] = []
        while res.count < count {
            if let rv = _random_resource_.anyOne {
                res.append(rv)
            }
        }
        return res.joined()
    }
}
