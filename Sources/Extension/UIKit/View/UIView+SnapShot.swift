//
//  UIView+SnapShot.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/21.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: ViewableType {
    
    func snapShot(opaque: Bool = true, scale: CGFloat = 0, afterScreenUpdates: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.bounds.size, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        base.view.drawHierarchy(in: base.bounds, afterScreenUpdates: afterScreenUpdates)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func snapShotView(opaque: Bool = true, scale: CGFloat = 0, afterScreenUpdates: Bool = true) -> UIImageView {
        let imageView = UIImageView(frame: base.bounds)
        imageView.image = snapShot(opaque: opaque, scale: scale, afterScreenUpdates: afterScreenUpdates)
        return imageView
    }
}
