//
//  UIButton+Edge.swift
//  Course
//
//  Created by damon on 2019/5/30.
//  Copyright © 2019 soso. All rights reserved.
//

import Foundation
import SDFoundation

public extension UIButton {
    
    /// image相对title的位置
    enum ImagePosition {
        case top
        case bottom
        case left
        case right
    }
}

public extension SDExtension where T: UIButton {
    
    func layoutButton(position: UIButton.ImagePosition, space imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = base.imageView?.frame.size.width ?? 0.0
        let imageHeight = base.imageView?.frame.size.height ?? 0.0
        
        let labelWidth: CGFloat = base.titleLabel?.intrinsicContentSize.width ?? 0.0
        let labelHeight: CGFloat = base.titleLabel?.intrinsicContentSize.height ?? 0.0
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据position和space得到imageEdgeInsets和labelEdgeInsets的值
        switch position {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-imageTitleSpace/2, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-imageTitleSpace/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-imageTitleSpace/2, left: -imageWidth, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-imageTitleSpace/2, bottom: 0, right: imageWidth+imageTitleSpace/2)
        }
        
        base.titleEdgeInsets = labelEdgeInsets
        base.imageEdgeInsets = imageEdgeInsets
    }
}
