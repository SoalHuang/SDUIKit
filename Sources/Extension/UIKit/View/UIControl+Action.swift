//
//  UIControl+Action.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/20.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIButton {
    
    /// 间隔delayInterval后才响应点击
    var delayInterval: TimeInterval {
        get { return base.kit_delayInterval ?? 0 }
        set { base.kit_delayInterval = newValue }
    }
}

public extension SDExtension where T: UIControl {
    
    @discardableResult
    func on(_ event: UIControl.Event = .touchUpInside, _ closure: @escaping @autoclosure () -> Void) -> SDExtension {
        var temp: [ControlTarget] = base.kit_controlTargets ?? []
        let target = ControlTarget(control: base, controlEvents: event) { _ in
            closure()
        }
        temp.append(target)
        base.kit_controlTargets = temp
        return self
    }
    
    @discardableResult
    func on(_ event: UIControl.Event = .touchUpInside, _ closure: @escaping (T) -> Void) -> SDExtension {
        var temp: [ControlTarget] = base.kit_controlTargets ?? []
        let target = ControlTarget(control: base, controlEvents: event) { _ in
            closure(self.base)
        }
        temp.append(target)
        base.kit_controlTargets = temp
        return self
    }
    
    @discardableResult
    func off(for event: UIControl.Event = .touchUpInside) -> SDExtension {
        base.kit_controlTargets?.filter({ $0.controlEvents == event }).forEach({ $0.dispose() })
        base.kit_controlTargets = base.kit_controlTargets?.filter({ $0.controlEvents != event })
        return self
    }
    
    @discardableResult
    func on(_ events: [UIControl.Event], _ closure: @escaping @autoclosure () -> Void) -> SDExtension {
        events.forEach { on($0, closure()) }
        return self
    }
    
    @discardableResult
    func on(_ events: [UIControl.Event], _ closure: @escaping (T) -> Void) -> SDExtension {
        events.forEach { on($0, closure) }
        return self
    }
    
    @discardableResult
    func off(for events: [UIControl.Event]) -> SDExtension {
        events.forEach { off(for: $0) }
        return self
    }
}

final fileprivate class ControlTarget: NSObject {
    
    weak var control: UIControl?
    let selector: Selector = #selector(ControlTarget.eventHandler(_:))
    let controlEvents: UIControl.Event
    var callback: ((UIControl) -> Void)?
    
    fileprivate init(control: UIControl, controlEvents: UIControl.Event, callback: ((UIControl) -> Void)?) {
        self.control = control
        self.controlEvents = controlEvents
        self.callback = callback
        super.init()
        control.addTarget(self, action: selector, for: controlEvents)
    }
    
    @objc fileprivate func eventHandler(_ sender: UIControl) {
        if let callback = self.callback, let control = self.control {
            callback(control)
        }
    }
    
    fileprivate func dispose() {
        self.control?.removeTarget(self, action: self.selector, for: self.controlEvents)
        self.callback = nil
    }
}

fileprivate extension NSObject {
    
    var kit_controlTargets: [ControlTarget]? {
        get { return sd.binded(for: &UIControl_Key_Target) }
        set { sd.bind(object: newValue, for: &UIControl_Key_Target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

private var UIControl_Key_Target: String = "object.sd.target.key"
private var UIControl_Key_ReActive_Delay: String = "object.sd.reactive.delay.key"
private var UIControl_Key_ReActive_TimeInt: String = "object.sd.reactive.timeInt.key"

extension UIButton {
    
    fileprivate var kit_delayInterval: TimeInterval? {
        get { return sd.binded(for: &UIControl_Key_ReActive_Delay) }
        set { sd.bind(object: newValue, for: &UIControl_Key_ReActive_Delay, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    fileprivate var kit_lastResponseTimeInt: TimeInterval? {
        get { return sd.binded(for: &UIControl_Key_ReActive_TimeInt) }
        set { sd.bind(object: newValue, for: &UIControl_Key_ReActive_TimeInt, .OBJC_ASSOCIATION_COPY_NONATOMIC)}
    }
    
    open override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard let delay = kit_delayInterval else {
            super.sendAction(action, to: target, for: event)
            return
        }
        guard let `lt` = kit_lastResponseTimeInt else {
            super.sendAction(action, to: target, for: event)
            kit_lastResponseTimeInt = Date().timeIntervalSince1970
            return
        }
        if Date().timeIntervalSince1970 - lt > delay {
            super.sendAction(action, to: target, for: event)
            kit_lastResponseTimeInt = Date().timeIntervalSince1970
        }
    }
}
