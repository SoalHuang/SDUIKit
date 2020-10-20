//
//  UIImage+PixelColor.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/20.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIImage {
    
    /// 某个像素点的颜色值
    func color(at point: CGPoint) -> UIColor? {
        return color(in: CGRect(x: point.x, y: point.y, width: 1, height: 1))
    }
    
    /// 某块像素点的平均颜色值
    func color(in rect: CGRect) -> UIColor? {
        let bounds = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        guard
            bounds.intersects(rect),
            let cgimage = base.cgImage,
            let dataProvider = cgimage.dataProvider,
            let data = dataProvider.data,
            let pointer = CFDataGetBytePtr(data)
            else {
                return nil
        }
        
        let comptsPerPixel = cgimage.bitsPerPixel / cgimage.bitsPerComponent
        
        let image_w = Int(base.size.width)
        
        let interRect = bounds.intersection(rect)
        
        let inter_x = Int(interRect.minX)
        let inter_y = Int(interRect.minY)
        let inter_w = Int(interRect.width)
        let inter_h = Int(interRect.height)
        
        var r: Int = 0
        var g: Int = 0
        var b: Int = 0
        var a: Int = 0
        
        for y in 0..<inter_h {
            for x in 0..<inter_w {
                let index = (image_w * (inter_y + y) + (inter_x + x)) * comptsPerPixel
                r += Int(pointer.advanced(by: index + 0).pointee)
                g += Int(pointer.advanced(by: index + 1).pointee)
                b += Int(pointer.advanced(by: index + 2).pointee)
                a += Int(pointer.advanced(by: index + 3).pointee)
            }
        }
        
        let pixelCount = inter_w * inter_h
        
        let red     = (CGFloat(r) / CGFloat(pixelCount)) / 255.0
        let green   = (CGFloat(g) / CGFloat(pixelCount)) / 255.0
        let blue    = (CGFloat(b) / CGFloat(pixelCount)) / 255.0
        let alpha   = (CGFloat(a) / CGFloat(pixelCount)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
