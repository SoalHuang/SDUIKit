//
//  NSLayoutManager+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/5/4.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: NSLayoutManager {
    
    var numberOfLines: Int {
        var lines: Int = 0
        var index: Int = 0
        while index < base.numberOfGlyphs {
            var lineRange: NSRange = NSRange()
            base.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            lines += 1
            index = NSMaxRange(lineRange)
        }
        return lines
    }
}
