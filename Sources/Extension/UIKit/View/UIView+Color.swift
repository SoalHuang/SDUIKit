//
//  UIView+Color.swift
//  SDUIKit
//
//  Created by SoalHunag on 2019/5/13.
//  Copyright © 2019 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: ViewableType {
    
    /// 获取某个坐标点的颜色
    func color(at point: CGPoint) -> UIColor? {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        defer { pixel.deallocate() }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue // RGBA
        guard let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        context.translateBy(x: -point.x , y: -point.y)
        base.layer.render(in: context)
        return UIColor(Int(pixel[0]), Int(pixel[1]), Int(pixel[2]), Int(pixel[3]))
    }
}
