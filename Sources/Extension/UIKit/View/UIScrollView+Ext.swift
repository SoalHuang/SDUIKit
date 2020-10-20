//
//  UIScrollView+Inset.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/4/26.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIScrollView {
    
    var isHolding: Bool {
        return base.isTracking || base.isDragging || base.isDecelerating
    }
    
    var isStayTop: Bool {
        return base.contentOffset.y == -base.contentInset.top
    }
    
    var isStayBottom: Bool {
        return base.contentOffset.y == base.contentSize.height - base.bounds.height + base.contentInset.bottom
    }
    
    @discardableResult
    func contentInset(_ closure: (inout UIEdgeInsets) -> Void) -> SDExtension {
        var inset = base.contentInset
        closure(&inset)
        base.contentInset = inset
        return self
    }
    
    @discardableResult
    func scrollToTop(offset: CGPoint = .zero, animated: Bool = false) -> SDExtension {
        let realOffset = CGPoint(x: offset.x, y: base.contentOffset.y - base.contentInset.top + offset.y)
        base.setContentOffset(realOffset, animated: animated)
        return self
    }
    
    @discardableResult
    func scrollToBottom(offset: CGPoint = .zero, animated: Bool = false) -> SDExtension {
        let realOffset = CGPoint(x: offset.x, y: base.contentSize.height - base.bounds.height + base.contentInset.bottom + offset.y)
        base.setContentOffset(realOffset, animated: animated)
        return self
    }
}
