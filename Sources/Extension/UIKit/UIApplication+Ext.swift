//
//  UIApplication+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/16.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIApplication {
    
    /// keyWindow的最上层视图控制器
    var topViewController: UIViewController? {
        return findTop(base.keyWindow?.rootViewController)
    }
    
    var orientationTransform: CGAffineTransform {
        switch base.statusBarOrientation {
        case .portrait:             return .identity
        case .portraitUpsideDown:   return CGAffineTransform(rotationAngle: .pi)
        case .landscapeLeft:        return CGAffineTransform(rotationAngle: .pi / -2.0)
        case .landscapeRight:       return CGAffineTransform(rotationAngle: .pi /  2.0)
        case .unknown:              return .identity
        @unknown default:           return .identity
        }
    }
    
    func exit() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        DispatchQueue.main.sd.delay(1) { Darwin.exit(EXIT_SUCCESS) }
    }
}

private func findTop(_ viewController: UIViewController?) -> UIViewController? {
    
    guard let vc = viewController else { return nil }
    
    if let tab = vc as? UITabBarController {
        return findTop(tab.selectedViewController)
    }
    if let nav = vc as? UINavigationController {
        return findTop(nav.topViewController)
    }
    if let presented = vc.presentedViewController {
        return findTop(presented)
    }
    return viewController
}
