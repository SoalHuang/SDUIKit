//
//  UITableView+Insets.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/9/18.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UITableView {
    
    @discardableResult
    func updateInset(top: CGFloat? = nil,
                     left: CGFloat? = nil,
                     bottom: CGFloat? = nil,
                     right: CGFloat? = nil) -> SDExtension {
        base.contentInset = base.contentInset.update(top: top,
                                                     left: left,
                                                     bottom: bottom,
                                                     right: right)
        return self
    }
}
