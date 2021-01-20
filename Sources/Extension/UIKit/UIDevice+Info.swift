//
//  UIDevice+Info.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/1/17.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import Foundation
import UIKit
import SDFoundation

public extension SDExtension where T == UIDevice {
    
    static let isSimulator: Bool = {
        var isSim = false
        #if targetEnvironment(simulator)
        isSim = true
        #endif
        return isSim
    }()
    
    var deviceType: DeviceType {
        return DeviceType.current
    }
}

/// Enum representing the different types of iOS devices available
public enum DeviceType: String, CaseIterable {
    
    case iPhone2G

    case iPhone3G
    case iPhone3GS

    case iPhone4
    case iPhone4S

    case iPhone5
    case iPhone5C
    case iPhone5S

    case iPhone6
    case iPhone6Plus

    case iPhone6S
    case iPhone6SPlus

    case iPhoneSE
    case iPhoneSE2

    case iPhone7
    case iPhone7Plus

    case iPhone8
    case iPhone8Plus
    
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    
    case iPhone12
    case iPhone12Mini
    case iPhone12Pro
    case iPhone12ProMax

    case iPhoneX

    case iPhoneXS
    case iPhoneXSMax
    
    case iPhoneXR

    case iPodTouch1
    case iPodTouch2
    case iPodTouch3
    case iPodTouch4
    case iPodTouch5
    case iPodTouch6
    case iPodTouch7

    case iPad
    case iPad2
    case iPad3
    case iPad4
    case iPad5
    case iPad6
    case iPad7
    case iPad8
    
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadMini5

    case iPadAir
    case iPadAir2
    case iPadAir3
    case iPadAir4

    case iPadPro9Inch
    case iPadPro10Inch
    case iPadPro11Inch
    case iPadPro11Inch2
    case iPadPro12Inch
    case iPadPro12Inch2
    case iPadPro12Inch3
    case iPadPro12Inch4

    case simulator
    case notAvailable

    // MARK: Constants

    /// The current device type
    public static var current: DeviceType {

        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""

        for child in mirror.children {
            if let value = child.value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }

        return DeviceType(identifier: identifier)
    }

    // MARK: Variables

    /// The display name of the device type
    public var displayName: String {

        switch self {
            
        case .iPhone2G: return "iPhone 2G"
        case .iPhone3G: return "iPhone 3G"
        case .iPhone3GS: return "iPhone 3GS"
            
        case .iPhone4: return "iPhone 4"
        case .iPhone4S: return "iPhone 4S"
            
        case .iPhone5: return "iPhone 5"
        case .iPhone5C: return "iPhone 5C"
        case .iPhone5S: return "iPhone 5S"
            
        case .iPhone6Plus: return "iPhone 6 Plus"
        case .iPhone6: return "iPhone 6"
        case .iPhone6S: return "iPhone 6S"
        case .iPhone6SPlus: return "iPhone 6S Plus"
            
        case .iPhoneSE: return "iPhone SE"
        case .iPhoneSE2: return "iPhone SE 2nd"
            
        case .iPhone7: return "iPhone 7"
        case .iPhone7Plus: return "iPhone 7 Plus"
            
        case .iPhone8: return "iPhone 8"
        case .iPhone8Plus: return "iPhone 8 Plus"
            
        case .iPhone11: return "iPhone 11"
        case .iPhone11Pro: return "iPhone 11 Pro"
        case .iPhone11ProMax: return "iPhone 11 Pro Max"
            
        case .iPhone12: return "iPhone 12"
        case .iPhone12Mini:  return "iPhone 12 Mini"
        case .iPhone12Pro:  return "iPhone 12 Pro"
        case .iPhone12ProMax:  return "iPhone 12 Pro Max"
            
        case .iPhoneX: return "iPhone X"
            
        case .iPhoneXS: return "iPhone XS"
        case .iPhoneXSMax: return "iPhone XS Max"
            
        case .iPhoneXR: return "iPhone XR"
            
        case .iPodTouch1: return "iPod Touch 1"
        case .iPodTouch2: return "iPod Touch 2"
        case .iPodTouch3: return "iPod Touch 3"
        case .iPodTouch4: return "iPod Touch 4"
        case .iPodTouch5: return "iPod Touch 5"
        case .iPodTouch6: return "iPod Touch 6"
        case .iPodTouch7: return "iPod Touch 7"
            
        case .iPad: return "iPad"
        case .iPad2: return "iPad 2"
        case .iPad3: return "iPad 3rd"
        case .iPad4: return "iPad 4th"
        case .iPad5: return "iPad 5th"
        case .iPad6: return "iPad 6th"
        case .iPad7: return "iPad 7th"
        case .iPad8: return "iPad 8th"
            
        case .iPadMini: return "iPad Mini"
        case .iPadMini2: return "iPad Mini 2"
        case .iPadMini3: return "iPad Mini 3"
        case .iPadMini4: return "iPad Mini 4"
        case .iPadMini5: return "iPad Mini 5th"
            
        case .iPadAir: return "iPad Air"
        case .iPadAir2: return "iPad Air 2"
        case .iPadAir3: return "iPad Air 3rd"
        case .iPadAir4: return "iPad Air 4th"
            
        case .iPadPro9Inch: return "iPad Pro 9 Inch"
        case .iPadPro10Inch: return "iPad Pro 10.5 Inch"
        case .iPadPro11Inch: return "iPad Pro 11 Inch"
        case .iPadPro11Inch2: return "iPad Pro 10.5 Inch 2nd"
        case .iPadPro12Inch: return "iPad Pro 12 Inch"
        case .iPadPro12Inch2: return "iPad Pro 12 Inch 2nd"
        case .iPadPro12Inch3: return "iPad Pro 12 Inch 3rd"
        case .iPadPro12Inch4: return "iPad Pro 12 Inch 4th"
            
        case .simulator: return "Simulator"
        case .notAvailable: return "Not Available"        }
    }

    /// The identifiers associated with each device type
    public var identifiers: [String] {

        switch self {
        case .notAvailable: return []
        case .simulator: return ["i386", "x86_64"]

        case .iPhone2G: return ["iPhone1,1"]
        case .iPhone3G: return ["iPhone1,2"]
        case .iPhone3GS: return ["iPhone2,1"]
            
        case .iPhone4: return ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
        case .iPhone4S: return ["iPhone4,1"]
            
        case .iPhone5: return ["iPhone5,1", "iPhone5,2"]
        case .iPhone5C: return ["iPhone5,3", "iPhone5,4"]
        case .iPhone5S: return ["iPhone6,1", "iPhone6,2"]
            
        case .iPhone6: return ["iPhone7,2"]
        case .iPhone6Plus: return ["iPhone7,1"]
            
        case .iPhone6S: return ["iPhone8,1"]
        case .iPhone6SPlus: return ["iPhone8,2"]
            
        case .iPhoneSE: return ["iPhone8,4"]
        case .iPhoneSE2: return ["iPhone12,8"]
            
        case .iPhone7: return ["iPhone9,1", "iPhone9,3"]
        case .iPhone7Plus: return ["iPhone9,2", "iPhone9,4"]
            
        case .iPhone8: return ["iPhone10,1", "iPhone10,4"]
        case .iPhone8Plus: return ["iPhone10,2", "iPhone10,5"]
            
        case .iPhoneX: return ["iPhone10,3", "iPhone10,6"]
        case .iPhoneXS: return ["iPhone11,2"]
        case .iPhoneXSMax: return ["iPhone11,4", "iPhone11,6"]
            
        case .iPhoneXR: return ["iPhone11,8"]
            
        case .iPhone11: return ["iPhone12,1"]
        case .iPhone11Pro: return ["iPhone12,3"]
        case .iPhone11ProMax: return ["iPhone12,5"]
            
        case .iPhone12: return ["iPhone13,2"]
        case .iPhone12Mini:  return ["iPhone13,1"]
        case .iPhone12Pro:  return ["iPhone13,3"]
        case .iPhone12ProMax:  return ["iPhone13,4"]
            
        case .iPodTouch1: return ["iPod1,1"]
        case .iPodTouch2: return ["iPod2,1"]
        case .iPodTouch3: return ["iPod3,1"]
        case .iPodTouch4: return ["iPod4,1"]
        case .iPodTouch5: return ["iPod5,1"]
        case .iPodTouch6: return ["iPod7,1"]
        case .iPodTouch7: return ["iPod9,1"]

        case .iPad: return ["iPad1,1", "iPad1,2"]
        case .iPad2: return ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
        case .iPad3: return ["iPad3,1", "iPad3,2", "iPad3,3"]
        case .iPad4: return ["iPad3,4", "iPad3,5", "iPad3,6"]
        case .iPad5: return ["iPad6,11", "iPad6,12"]
        case .iPad6: return ["iPad7,5", "iPad7,6"]
        case .iPad7: return ["iPad7,11", "iPad7,12"]
        case .iPad8: return ["iPad11.6", "iPad11.7"]
            
        case .iPadMini: return ["iPad2,5", "iPad2,6", "iPad2,7"]
        case .iPadMini2: return ["iPad4,4", "iPad4,5", "iPad4,6"]
        case .iPadMini3: return ["iPad4,7", "iPad4,8", "iPad4,9"]
        case .iPadMini4: return ["iPad5,1", "iPad5,2"]
        case .iPadMini5: return ["iPad11,1", "iPad11,2"]
            
        case .iPadAir: return ["iPad4,1", "iPad4,2", "iPad4,3"]
        case .iPadAir2: return ["iPad5,3", "iPad5,4"]
        case .iPadAir3: return ["iPad11,3", "iPad11,4"]
        case .iPadAir4: return ["iPad13,1", "iPad13,2"]
            
        case .iPadPro9Inch: return ["iPad6,3", "iPad6,4"]
        case .iPadPro10Inch: return ["iPad7,3", "iPad7,4"]
        case .iPadPro11Inch: return ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
        case .iPadPro11Inch2: return ["iPad8,9", "iPad8,10"]
        case .iPadPro12Inch: return ["iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2"]
        case .iPadPro12Inch2: return ["iPad7,1", "iPad7,2"]
        case .iPadPro12Inch3: return ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
        case .iPadPro12Inch4: return ["iPad8,11", "iPad8,12"]
        }
    }

    // MARK: Inits

    /// Creates a device type
    ///
    /// - Parameter identifier: The identifier of the device
    public init(identifier: String) {

        for device in DeviceType.allCases {
            for deviceId in device.identifiers {
                guard identifier == deviceId else { continue }
                self = device
                return
            }
        }
        
        self = .notAvailable
    }
}
