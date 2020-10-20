//
//  UILabel+Shadow.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import UIKit

public extension UILabel {
    
    func applyShadow(color: UIColor = UIColor(hex: 0x000000).withAlphaComponent(0.25)) {
        layerShadowColor = color
        layerShadowOpacity = 1
        layerShadowOffset = CGSize(width: 1, height: 1)
    }
}
