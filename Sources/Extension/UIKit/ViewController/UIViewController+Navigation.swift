//
//  UIViewController+Navigation.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/6.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T : UIViewController {
    
    var isRoot: Bool {
        return base.navigationController?.viewControllers.first == base
    }
    
    var isShowHome: Bool {
        guard let vcs = base.navigationController?.viewControllers else { return false }
        return vcs.count > 2
    }
}

public extension SDExtension where T : UIViewController {
    
    func filter(without withoutType: UIViewController.Type) {
        base.filter(without: [withoutType])
    }
    
    func filter(without withoutTypes: [UIViewController.Type]) {
        base.filter(without: withoutTypes)
    }
    
    func navigationPrefixToSelf(without withoutTypes: [UIViewController.Type] = []) {
        base.navigationPrefixToSelf(without: withoutTypes)
    }
    
    func navigationSuffixToSelf(without withoutTypes: [UIViewController.Type] = []) {
        base.navigationSuffixToSelf(without: withoutTypes)
    }
    
    func navigationPrefix(to toType: UIViewController.Type, without withoutTypes: [UIViewController.Type] = []) {
        base.navigationPrefix(to: toType, without: withoutTypes)
    }
    
    func navigationSuffix(to toType: UIViewController.Type, without withoutTypes: [UIViewController.Type] = []) {
        base.navigationSuffix(to: toType, without: withoutTypes)
    }
}

extension UIViewController {
    
    func filter(without withoutTypes: [UIViewController.Type]) {
        navigationController?.viewControllers = navigationController?.viewControllers.filter { vc in !withoutTypes.contains { t in t === type(of: vc) } } ?? [self]
    }
    
    func navigationPrefixToSelf(without withoutTypes: [UIViewController.Type]) {
        return navigationPrefix(to: type(of: self), without: withoutTypes)
    }
    
    func navigationSuffixToSelf(without withoutTypes: [UIViewController.Type]) {
        return navigationSuffix(to: type(of: self), without: withoutTypes)
    }
    
    func navigationPrefix(to toType: UIViewController.Type, without withoutTypes: [UIViewController.Type]) {
        guard let navVc = navigationController else { return }
        var vcs = navVc.viewControllers.filter { vc in !withoutTypes.contains { t in t === type(of: vc)} }
        guard
            vcs.count > 1,
            let firstIndex = vcs.firstIndex(where: { type(of: $0) === toType }),
            firstIndex > vcs.startIndex,
            firstIndex < vcs.endIndex
            else {
                navVc.viewControllers = vcs
                return
        }
        vcs = vcs.prefix(firstIndex).compactMap { $0 }
        vcs.append(self)
        navVc.viewControllers = vcs
    }
    
    func navigationSuffix(to toType: UIViewController.Type, without withoutTypes: [UIViewController.Type] = []) {
        guard let navVc = navigationController else { return }
        let vcs = navVc.viewControllers.filter { vc in !withoutTypes.contains { t in t === type(of: vc)} }
        guard
            vcs.count > 1,
            let lastIndex = vcs.lastIndex(where: { type(of: $0) === toType }),
            lastIndex > vcs.startIndex,
            lastIndex < vcs.endIndex
            else {
                navVc.viewControllers = vcs
                return
        }
        navigationController?.viewControllers = vcs.suffix(from: lastIndex).compactMap { $0 }
    }
}
