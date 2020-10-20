//
//  Constants.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public struct Constants {
    
    public struct StatusBar {
        
        public static var size: CGSize {
            return UIApplication.shared.statusBarFrame.size
        }
    }
    
    public struct NavgationBar {
        
        public static let height: CGFloat = 44.0
    }
    
    public struct TabBar {
        
        public static let height: CGFloat = 49.0
    }
    
    public struct SafeArea {
        
        public static var top: CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? (DeviceIsXGroup ? 44 : 0)
        }
        
        public static var left: CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            return UIApplication.shared.keyWindow?.safeAreaInsets.left ?? (DeviceIsXGroup ? 34 : 0)
        }
        
        public static var bottom: CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? (DeviceIsXGroup ? 34 : 0)
        }
        
        public static var right: CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            return UIApplication.shared.keyWindow?.safeAreaInsets.right ?? (DeviceIsXGroup ? 34 : 0)
        }
        
        public static let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
