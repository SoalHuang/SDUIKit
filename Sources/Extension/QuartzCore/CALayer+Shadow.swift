//
//  CALayer+Shadow.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/30.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: CALayer {
    
    @discardableResult
    func shadowApply(color: UIColor = .black,
                       opacity: Float = 0.5,
                       offset: CGSize = .zero,
                       radius: CGFloat = 5,
                       maskToBounds: Bool = false,
                       shouldRasterize: Bool = true,
                       rasterizationScale: CGFloat = UIScreen.main.scale,
                       shadowPath: CGPath? = nil) -> SDExtension {
        
        base.shadowColor     = color.cgColor
        base.shadowOpacity   = opacity
        base.shadowOffset    = offset
        base.shadowRadius    = radius
        base.masksToBounds   = maskToBounds
        base.shouldRasterize = shouldRasterize
        base.rasterizationScale = rasterizationScale
        if let `shadowPath` = shadowPath {
            base.shadowPath = shadowPath
        }
        return self
    }
    
    @discardableResult
    func shadowRemove() -> SDExtension {
        base.shadowColor    = UIColor.clear.cgColor
        base.shadowOpacity  = 0.0
        base.shadowOffset   = .zero
        base.shadowRadius   = 0
        base.shadowPath     = nil
        return self
    }
}
