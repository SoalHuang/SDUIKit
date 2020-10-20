//
//  NSObject+Keyboard.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/4/26.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: NSObject {
    
    var lastKeyboard: SDKeyBoard? {
        return base.kit_last_keyboard
    }
    
    @discardableResult
    func addKeyboard(notification name: SDKeyBoard.Name, _ closure: @escaping SDKeyBoard.Closure) -> SDExtension {
        base.sd.addNotification(name: name.notificationName, object: nil) { [weak base] notification in
            let info = SDKeyBoard.Info(notification)
            closure(name, info)
            base?.kit_last_keyboard = SDKeyBoard(name: name, info: info)
        }
        return self
    }
    
    @discardableResult
    func addKeyboard(notification name: SDKeyBoard.Name, _ closure: @escaping (SDKeyBoard.Info) -> Void) -> SDExtension {
        base.sd.addNotification(name: name.notificationName, object: nil) { [weak base] notification in
            let info = SDKeyBoard.Info(notification)
            closure(info)
            base?.kit_last_keyboard = SDKeyBoard(name: name, info: info)
        }
        return self
    }
    
    @discardableResult
    func addKeyboard(notification name: SDKeyBoard.Name, _ closure: @escaping () -> Void) -> SDExtension {
        base.sd.addNotification(name: name.notificationName, object: nil) { [weak base] notification in
            let info = SDKeyBoard.Info(notification)
            closure()
            base?.kit_last_keyboard = SDKeyBoard(name: name, info: info)
        }
        return self
    }
    
    @discardableResult
    func addKeyboard(notification names: [SDKeyBoard.Name], _ closure: @escaping SDKeyBoard.Closure) -> SDExtension {
        names.forEach { addKeyboard(notification: $0, closure) }
        return self
    }
    
    @discardableResult
    func addKeyboard(notification names: [SDKeyBoard.Name], _ closure: @escaping (SDKeyBoard.Info) -> Void) -> SDExtension {
        names.forEach { addKeyboard(notification: $0, closure) }
        return self
    }
    
    @discardableResult
    func addKeyboard(notification names: [SDKeyBoard.Name], _ closure: @escaping () -> Void) -> SDExtension {
        names.forEach { addKeyboard(notification: $0, closure) }
        return self
    }
    
    @discardableResult
    func removeKeyboard() -> SDExtension {
        let baseSD = base.sd
        SDKeyBoard.Name.allCases.forEach { baseSD.removeNotification(name: $0.notificationName) }
        return self
    }
    
    @discardableResult
    func removeKeyboard(notification type: SDKeyBoard.Name) -> SDExtension {
        base.sd.removeNotification(name: type.notificationName)
        return self
    }
    
    @discardableResult
    func removeKeyboard(notification types: [SDKeyBoard.Name]) -> SDExtension {
        let baseSD = base.sd
        types.forEach { baseSD.removeNotification(name: $0.notificationName) }
        return self
    }
}

fileprivate extension NSObject {
    
    var kit_last_keyboard: SDKeyBoard? {
        get { return sd.binded(for: &SDKeyBoard.lastKeyboardKey) }
        set { sd.bind(object: newValue, for: &SDKeyBoard.lastKeyboardKey, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

public struct SDKeyBoard {
    
    fileprivate static var lastKeyboardKey: String = "observer.keyboard.last.key"
    
    public typealias Closure = (Name, Info) -> Void
    
    public enum Name: CaseIterable {
        
        case willShow
        case didShow
        case willHide
        case didHide
        case willChange
        case didChange
        
        var notificationName: Notification.Name {
            switch self {
            case .willShow:     return UIResponder.keyboardWillShowNotification
            case .didShow:      return UIResponder.keyboardDidShowNotification
            case .willHide:     return UIResponder.keyboardWillHideNotification
            case .didHide:      return UIResponder.keyboardDidHideNotification
            case .willChange:   return UIResponder.keyboardWillChangeFrameNotification
            case .didChange:    return UIResponder.keyboardDidChangeFrameNotification
            }
        }
    }
    
    public struct Info {
        public var beginFrame:  CGRect?
        public var endFrame:    CGRect?
        public var duration:    TimeInterval?
        public var curve:       TimeInterval?
        public var isLocal:     Bool?
        public init(_ notification: Notification) {
            beginFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
            endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval
            isLocal = notification.userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as? Bool
        }
    }
    
    public var name: SDKeyBoard.Name
    public var info: SDKeyBoard.Info
}
