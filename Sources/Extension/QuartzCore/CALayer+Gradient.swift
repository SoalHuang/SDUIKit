//
//  CALayer+Gradient.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/30.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: CALayer {
    
    @discardableResult
    func gradientApply(frame: CGRect, start: CGPoint, end: CGPoint, colors: [UIColor]) -> SDExtension {
        let gradient = base.gradientLayer ?? CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.colors = colors.compactMap { $0.cgColor }
        if gradient.superlayer == nil {
            base.insertSublayer(gradient, at: 0)
        }
        base.gradientLayer = gradient
        return self
    }
    
    @discardableResult
    func gradientRemove() -> SDExtension {
        base.gradientLayer?.removeFromSuperlayer()
        base.gradientLayer = nil
        return self
    }
    
    var gradientLayer: CAGradientLayer? {
        get { return base.gradientLayer }
        set { base.gradientLayer = newValue }
    }
}

fileprivate extension CALayer {
    
    private static var gradientLayerBindKey: String = "com.sd.layer.gradient.layer.bind.key"
    var gradientLayer: CAGradientLayer? {
        get { return sd.binded(for: &CALayer.gradientLayerBindKey) }
        set { sd.bind(object: newValue, for: &CALayer.gradientLayerBindKey, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
