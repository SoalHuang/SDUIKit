//
//  UICollectionView+Reuse.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/20.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UICollectionView {
    
    //MARK: - Cell
    @discardableResult
    func registerNibWithCell<CellType: UICollectionViewCell>(_ cell: CellType.Type) -> SDExtension {
        let name = String(describing: cell)
        base.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
        return self
    }
    
    @discardableResult
    func registerClassWithCell<CellType: UICollectionViewCell>(_ cell: CellType.Type) -> SDExtension {
        base.register(cell, forCellWithReuseIdentifier: String(describing: cell))
        return self
    }
    
    func dequeueCell<CellType: UICollectionViewCell>(_ cell: CellType.Type, for indexPath: IndexPath) -> CellType {
        return base.dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! CellType
    }
    
    //MARK: - HeaderView
    @discardableResult
    func registerNibHeader<CellType: UICollectionReusableView>(_ type: CellType.Type) -> SDExtension {
        let name = String(describing: type)
        base.register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
        return self
    }
    
    @discardableResult
    func registerClassHeader<CellType: UICollectionReusableView>(_ type: CellType.Type) -> SDExtension {
        base.register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: type))
        return self
    }
    
    func dequeueHeader<CellType: UICollectionReusableView>(_ type: CellType.Type, for indexPath: IndexPath) -> CellType {
        return base.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: type), for: indexPath) as! CellType
    }
    
    //MARK: - FooterView
    @discardableResult
    func registerNibFooter<CellType: UICollectionReusableView>(_ type: CellType.Type) -> SDExtension {
        let name = String(describing: type)
        base.register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
        return self
    }
    
    @discardableResult
    func registerClassFooter<CellType: UICollectionReusableView>(_ type: CellType.Type) -> SDExtension {
        base.register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: type))
        return self
    }
    
    func dequeueFooter<CellType: UICollectionReusableView>(_ type: CellType.Type, for indexPath: IndexPath) -> CellType {
        return base.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: type), for: indexPath) as! CellType
    }
}
