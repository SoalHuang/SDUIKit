//
//  NSMutableParagraphStyle+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/30.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit

public extension NSMutableParagraphStyle {
    
    convenience init(lineSpacing: CGFloat? = nil,
                     paragraphSpacing: CGFloat? = nil,
                     alignment: NSTextAlignment? = nil,
                     firstLineHeadIndent: CGFloat? = nil,
                     headIndent: CGFloat? = nil,
                     tailIndent: CGFloat? = nil,
                     lineBreakMode: NSLineBreakMode? = nil,
                     minimumLineHeight: CGFloat? = nil,
                     maximumLineHeight: CGFloat? = nil,
                     baseWritingDirection: NSWritingDirection? = nil,
                     lineHeightMultiple: CGFloat? = nil,
                     paragraphSpacingBefore: CGFloat? = nil,
                     hyphenationFactor: Float? = nil) {
        self.init()
        if let lineSpacing = lineSpacing {
            self.lineSpacing = lineSpacing
        }
        if let paragraphSpacing = paragraphSpacing {
            self.paragraphSpacing = paragraphSpacing
        }
        if let alignment = alignment {
            self.alignment = alignment
        }
        if let firstLineHeadIndent = firstLineHeadIndent {
            self.firstLineHeadIndent = firstLineHeadIndent
        }
        if let headIndent = headIndent {
            self.headIndent = headIndent
        }
        if let tailIndent = tailIndent {
            self.tailIndent = tailIndent
        }
        if let lineBreakMode = lineBreakMode {
            self.lineBreakMode = lineBreakMode
        }
        if let minimumLineHeight = minimumLineHeight {
            self.minimumLineHeight = minimumLineHeight
        }
        if let maximumLineHeight = maximumLineHeight {
            self.maximumLineHeight = maximumLineHeight
        }
        if let baseWritingDirection = baseWritingDirection {
            self.baseWritingDirection = baseWritingDirection
        }
        if let lineHeightMultiple = lineHeightMultiple {
            self.lineHeightMultiple = lineHeightMultiple
        }
        if let paragraphSpacingBefore = paragraphSpacingBefore {
            self.paragraphSpacingBefore = paragraphSpacingBefore
        }
        if let hyphenationFactor = hyphenationFactor {
            self.hyphenationFactor = hyphenationFactor
        }
    }
}
