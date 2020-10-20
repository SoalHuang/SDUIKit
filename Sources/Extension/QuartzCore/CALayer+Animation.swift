//
//  CALayer+Animation.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/30.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: CALayer {
    
    func popup(_ duration: TimeInterval) {
        let animate = CAKeyframeAnimation(keyPath: "transform")
        animate.values = [CATransform3DMakeScale(0.5, 0.5, 0.5),
                          CATransform3DMakeScale(1.1, 1.1, 1.0),
                          CATransform3DMakeScale(1.0, 1.0, 1.0)]
        animate.duration = duration
        base.add(animate, forKey:"popup")
    }
}
