//
//  UIView+Layout.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/16.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIView {
    
    var top: CGFloat {
        get { return base.frame.minY }
        set {
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
    }
    
    var left: CGFloat {
        get { return base.frame.minX }
        set {
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get { return base.frame.maxY }
        set {
            var frame = base.frame
            frame.origin.y = newValue - frame.height
            base.frame = frame
        }
    }
    
    var right: CGFloat {
        get { return base.frame.maxX }
        set {
            var frame = base.frame
            frame.origin.x = newValue - frame.width
            base.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get { return base.frame.midX }
        set {
            var frame = base.frame
            frame.origin.x = newValue - frame.width / 2.0
            base.frame = frame
        }
    }
    
    var centerY: CGFloat {
        get { return base.frame.midY }
        set {
            var frame = base.frame
            frame.origin.y = newValue - frame.height / 2.0
            base.frame = frame
        }
    }
    
    var origin: CGPoint {
        get { return base.frame.origin }
        set {
            var frame = base.frame
            frame.origin = newValue
            base.frame = frame
        }
    }
    
    var center: CGPoint {
        get { return base.center}
        set { base.center = newValue }
    }
    
    var size: CGSize {
        get { return base.frame.size }
        set {
            var frame = base.frame
            frame.size = newValue
            base.frame = frame
        }
    }
    
    var width: CGFloat {
        get { return base.frame.width }
        set {
            var frame = base.frame
            frame.size.width = newValue
            base.frame = frame
        }
    }
    
    var height: CGFloat {
        get { return base.frame.height }
        set {
            var frame = base.frame
            frame.size.height = newValue
            base.frame = frame
        }
    }
    
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return base.safeAreaInsets
        } else {
            return .zero
        }
    }
}

public extension SDExtension where T: UIView {
    
    func layout(_ closure: (_ maker: SDViewLayoutMaker) -> Void) {
        let m = SDViewLayoutMaker(rect: base.frame)
        closure(m)
        base.frame = m.frame
    }
}

public class SDViewLayoutMaker {
    
    public var frame: CGRect = .zero
    
    public init(rect: CGRect) {
        self.frame = rect
    }
}

public extension SDViewLayoutMaker {
    
    var top: CGFloat {
        get { return frame.minY }
        set { frame.origin.y = newValue }
    }
    
    var left: CGFloat {
        get { return frame.minX }
        set { frame.origin.x = newValue }
    }
    
    var bottom: CGFloat {
        get { return frame.maxY }
        set { frame.origin.y = newValue - frame.height }
    }
    
    var right: CGFloat {
        get { return frame.maxX }
        set { frame.origin.x = newValue - frame.width }
    }
    
    var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    
    var width: CGFloat {
        get { return frame.width }
        set { frame.size.width = newValue }
    }
    
    var height: CGFloat {
        get { return frame.height }
        set { frame.size.height = newValue }
    }
    
    var center: CGPoint {
        get { return CGPoint(x: frame.midX, y: frame.midY) }
        set { frame.origin = CGPoint(x: newValue.x - frame.width / 2, y: newValue.y - frame.height / 2) }
    }
    
    var centerX: CGFloat {
        get { return frame.midX }
        set { frame.origin.x = newValue - frame.width / 2 }
    }
    
    var centerY: CGFloat {
        get { return frame.midY }
        set { frame.origin.y = newValue - frame.height / 2 }
    }
}
