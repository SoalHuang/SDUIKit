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
    
    static var isIPhone4:       Bool { DeviceIsiPhone4 }
    
    static var isIPhone5:       Bool { DeviceIsiPhone5 }
    
    static var isIphone6:       Bool { DeviceIsiPhone6 }
    static var isIphone6p:      Bool { DeviceIsiPhone6p }
    
    static var isIPhoneX:       Bool { DeviceIsiPhoneX }
    static var isIPhoneXR:      Bool { DeviceIsiPhoneXR }
    static var isIPhoneMX:      Bool { DeviceIsiPhoneMX }
    
    static var isIPhone12:      Bool { DeviceIsiPhone12 }
    static var isIPhone12Mini:  Bool { DeviceIsiPhone12Mini }
    static var isIPhone12Pro:   Bool { DeviceIsiPhone12Pro }
    
    static var isXGroup:        Bool { DeviceIsXGroup }
}
