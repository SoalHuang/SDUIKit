//
//  UIView+Xib.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/20.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIView {
    
    @discardableResult
    static func loadXib(_ bundle: Bundle = Bundle.main, _ index: Int = 0) -> T {
        return T.loadXib(bundle, index)
    }
}

public protocol SDLoadXib { }

public extension SDLoadXib {
    
    @discardableResult
    static func loadXib(_ bundle: Bundle = Bundle.main, _ index: Int = 0) -> Self {
        return bundle.loadNibNamed(String(describing: self), owner: self, options: nil)?[index] as! Self
    }
}

extension UIView: SDLoadXib {  }

