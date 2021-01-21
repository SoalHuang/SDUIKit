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
