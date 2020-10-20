//
//  String+BoundingRect.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/7.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation
import CoreGraphics.CGGeometry

public extension SDExtension where T == String {
    
    func boundingHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width,
                                    height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin).union(.truncatesLastVisibleLine)
        let boundingBox = base.boundingRect(with: constraintRect,
                                            options: options,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.height.sd.ceil
    }
    
    func boundingWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width,
                                    height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin).union(.truncatesLastVisibleLine)
        let boundingBox = base.boundingRect(with: constraintRect,
                                            options: options,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.width.sd.ceil
    }
    
    func boundingWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude,
                                    height: height)
        let boundingBox = base.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.width.sd.ceil
    }
    
    func boundingSize(width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width,
                                    height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin).union(.truncatesLastVisibleLine)
        let boundingBox = base.boundingRect(with: constraintRect,
                                            options: options,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.size.sd.ceil
    }
}
