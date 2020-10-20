//
//  UIPickerView+InputKeyboard.swift
//  SDUIKit
//
//  Created by SoalHunag on 2019/3/25.
//  Copyright © 2019 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

extension SDExtension where T: UIPickerView {
    
    public func inputKeyboard(with frame: CGRect) -> InputKeyboard<T> {
        return InputKeyboard(frame: frame, content: base)
    }
}
