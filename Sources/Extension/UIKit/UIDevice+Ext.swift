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

public let UUIDKeychainKey: String = "com.sunlands.uuid"

public extension SDExtension where T: UIDevice {
    
    /// UUID, 如果没获取到identifierForVendor.uuidString就自己生成一个
    var uuid: String {
        if let keychainedId = getKeychainedUUID() {
            return keychainedId
        }
        let newId = UIDevice.current.identifierForVendor?.uuidString ?? random()
        setKeychainUUID(newId)
        return newId
    }
    
    private func getKeychainedUUID() -> String? {
        let keychain = KeychainSwift()
        guard
            let data = keychain.getData(UUIDKeychainKey),
            let id = String(data: data, encoding: .utf8)
            else { return nil }
        return id
    }
    
    private func setKeychainUUID(_ id: String?) {
        guard let `id` = id, let data = id.data(using: .utf8) else { return }
        let keychain = KeychainSwift()
        keychain.set(data, forKey: UUIDKeychainKey)
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
