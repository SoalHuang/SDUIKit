//
//  UIEdgeInsets+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/9/17.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

extension UIEdgeInsets: SDExtensionCompatible { }

public extension UIEdgeInsets {
    
    init(_ value: CGFloat) {
        self = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    init(t: CGFloat = 0, l: CGFloat = 0, b: CGFloat = 0, r: CGFloat = 0) {
        self = UIEdgeInsets(top: t, left: l, bottom: b, right: r)
    }
    
    init(_ elements: [CGFloat]) {
        self = UIEdgeInsets(top: elements[safe: 0] ?? 0,
                            left: elements[safe: 1] ?? 0,
                            bottom: elements[safe: 2] ?? 0,
                            right: elements[safe: 3] ?? 0)
    }
}

extension UIEdgeInsets: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: CGFloat...) {
        self = UIEdgeInsets(top: elements[safe: 0] ?? 0,
                            left: elements[safe: 1] ?? 0,
                            bottom: elements[safe: 2] ?? 0,
                            right: elements[safe: 3] ?? 0)
    }
}

public extension UIEdgeInsets {
    
    func update(top: CGFloat? = nil,
                left: CGFloat? = nil,
                bottom: CGFloat? = nil,
                right: CGFloat? = nil) -> UIEdgeInsets {
        return UIEdgeInsets(top: top ?? self.top,
                            left: left ?? self.left,
                            bottom: bottom ?? self.bottom,
                            right: right ?? self.right)
    }
}

extension UIEdgeInsets {
    
    public static func + (_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top + rhs.top,
                            left: lhs.left + rhs.left,
                            bottom: lhs.bottom + rhs.bottom,
                            right: lhs.right + rhs.right)
    }
    
    public static func - (_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top - rhs.top,
                            left: lhs.left - rhs.left,
                            bottom: lhs.bottom - rhs.bottom,
                            right: lhs.right - rhs.right)
    }
    
    public static func * (_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top * rhs,
                            left: lhs.left * rhs,
                            bottom: lhs.bottom * rhs,
                            right: lhs.right * rhs)
    }
}

public extension SDExtension where T == UIEdgeInsets {
    
    var autoScale: T {
        return scale(AutoScale)
    }
    
    var autoScaleMax: T {
        return scale(AutoScaleMax)
    }
    
    func scale(_ scale: CGFloat) -> T {
        return base * scale
    }
}

//public extension SDExtension where T == Array<UIEdgeInsets> {
//    
//    var autoScale: [T.Element] {
//        return scale(AutoScale)
//    }
//    
//    var autoScaleMax: [T.Element] {
//        return scale(AutoScaleMax)
//    }
//    
//    func scale(_ scale: CGFloat) -> [T.Element] {
//        return base.compactMap { $0 * scale }
//    }
//}
