//
//  UITableView+Reuse.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/20.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UITableView {
    
    //MARK: - Cell
    @discardableResult
    func registerNibWithCell<CellType: UITableViewCell>(_ cell: CellType.Type) -> SDExtension {
        let name = String(describing: cell)
        base.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        return self
    }
    
    @discardableResult
    func registerClassWithCell<CellType: UITableViewCell>(_ cell: CellType.Type) -> SDExtension {
        base.register(cell, forCellReuseIdentifier: String(describing: cell))
        return self
    }
    
    func dequeueCell<CellType: UITableViewCell>(_ cell: CellType.Type) -> CellType {
        return base.dequeueReusableCell(withIdentifier: String(describing: cell)) as! CellType
    }
    
    func dequeueCell<CellType: UITableViewCell>(_ cell: CellType.Type, for indexPath: IndexPath) -> CellType {
        return base.dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! CellType
    }
    
    //MARK: - HeaderFooterView
    @discardableResult
    func registerNibWithHeaderFooterView<CellType: UITableViewHeaderFooterView>(_ headerFooterView: CellType.Type) -> SDExtension {
        let name = String(describing: headerFooterView)
        base.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
        return self
    }
    
    @discardableResult
    func registerClassWithHeaderFooterView<CellType: UITableViewHeaderFooterView>(_ headerFooterView: CellType.Type) -> SDExtension {
        base.register(headerFooterView, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterView))
        return self
    }
    
    func dequeueHeaderFooterView<CellType: UITableViewHeaderFooterView>(_ headerFooterView: CellType.Type) -> CellType {
        return base.dequeueReusableHeaderFooterView(withIdentifier: String(describing: headerFooterView)) as! CellType
    }
}
