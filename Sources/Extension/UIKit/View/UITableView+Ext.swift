//
//  UITableView+SD.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/4/27.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UITableView {
    
    @discardableResult
    func separatorInset(_ closure: (inout UIEdgeInsets) -> Void) -> SDExtension {
        var inset = base.separatorInset
        closure(&inset)
        base.separatorInset = inset
        return self
    }
    
    func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition) {
        guard let paths = base.indexPathsForVisibleRows, let path = indexPath, paths.contains(path) else { return }
        base.selectRow(at: path, animated: animated, scrollPosition: scrollPosition)
    }
    
    func deselectRow(at indexPath: IndexPath, animated: Bool) {
        guard let paths = base.indexPathsForVisibleRows, paths.contains(indexPath) else { return }
        base.deselectRow(at: indexPath, animated: animated)
    }
}
