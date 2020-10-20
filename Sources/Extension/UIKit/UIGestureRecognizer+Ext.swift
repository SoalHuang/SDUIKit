//
//  UIGestureRecognizer+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/4/26.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIGestureRecognizer {
    
    @discardableResult
    static func gesture(_ closure: @escaping (UIGestureRecognizer) -> Void) -> SDExtension {
        return T().sd.on(closure)
    }
    
    @discardableResult
    func on(_ closure: @escaping (UIGestureRecognizer) -> Void) -> SDExtension {
        base.isEnabled = true
        var temp: [ObserverGestureTarget] = base.kit_gestureTargets ?? []
        let target = ObserverGestureTarget(gesture: base) { closure($0) }
        temp.append(target)
        base.kit_gestureTargets = temp
        return self
    }
    
    @discardableResult
    func off() -> SDExtension {
        base.isEnabled = false
        base.kit_gestureTargets?.forEach({ $0.dispose() })
        base.kit_gestureTargets?.removeAll()
        return self
    }
}

fileprivate extension NSObject {
    
    var kit_gestureTargets: [ObserverGestureTarget]? {
        get { return sd.binded(for: &ObserverGestureTarget.targetKey) }
        set { sd.bind(object: newValue, for: &ObserverGestureTarget.targetKey, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

final fileprivate class ObserverGestureTarget: NSObject {
    
    fileprivate static var targetKey: String = "observer.gesture.target.key"
    weak var gesture: UIGestureRecognizer?
    let selector: Selector = #selector(ObserverGestureTarget.eventHandler(_:))
    var callback: ((UIGestureRecognizer) -> Void)?
    
    fileprivate init(gesture: UIGestureRecognizer, callback: ((UIGestureRecognizer) -> Void)?) {
        self.gesture = gesture
        self.callback = callback
        super.init()
        gesture.addTarget(self, action: selector)
    }
    
    @objc private func eventHandler(_ gesture: UIGestureRecognizer) {
        callback?(gesture)
    }
    
    fileprivate func dispose() {
        gesture?.removeTarget(self, action: selector)
        self.callback = nil
    }
}
