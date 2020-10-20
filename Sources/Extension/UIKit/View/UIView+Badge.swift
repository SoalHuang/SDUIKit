//
//  UIView+Badge.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/30.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: ViewableType {
    
    var badge: UIViewBadgeProxy {
        return UIViewBadgeProxy(base: base)
    }
}

public class UIViewBadgeProxy {
    
    public enum Values {
        case none
        case dot
        case text(String?)
    }
    
    private let badgeTag: Int = 0xeeee
    private let valueMaxSize: CGSize = CGSize(width: 100, height: 20)
    
    private var base: ViewableType
    fileprivate init(base: ViewableType) {
        self.base = base
    }
    
    @discardableResult
    public func value(_ value: Values,
                      size: CGSize = CGSize(width: 10, height: 10),
                      offset: CGPoint = .zero,
                      borderWidth: CGFloat = 1.0,
                      borderColor: UIColor = .white) -> UIViewBadgeProxy {
        self.value = value
        self.offset = offset
        switch value {
        case .none: removeBadge()
        case .dot:
            addBadge()
            badgeView.text = nil
            badgeView.layer.borderWidth = borderWidth
            badgeView.layer.borderColor = borderColor.cgColor
            layout(size, offset)
        case .text(let textValue):
            guard let `textValue` = textValue else {
                removeBadge()
                return self
            }
            addBadge()
            badgeView.text = textValue
            badgeView.layer.borderWidth = borderWidth
            badgeView.layer.borderColor = borderColor.cgColor
            var size = badgeView.sizeThatFits(valueMaxSize).sd.ceil
            size = CGSize(width: max(size.width, valueMaxSize.height), height: max(size.height, valueMaxSize.height))
            layout(size, offset)
        }
        return self
    }
    
    private var value: Values = .none
    private var offset: CGPoint = .zero
    
    private func addBadge() {
        if let _ = badgeView.superview { return }
        base.addSub(badgeView)
        badgeView.layer.sd.popup(0.2)
    }
    
    private func removeBadge() {
        guard let _ = badgeView.superview else { return }
        badgeView.removeFromSuperview()
    }
    
    private func layout(_ size: CGSize, _ offset: CGPoint) {
        badgeView.layer.cornerRadius = size.height / 2.0
        badgeView.sd.layout {
            $0.size = size
            $0.center = CGPoint(x: base.bounds.width + offset.x, y: offset.y)
        }
    }
    
    private var badgeView: UILabel {
        if let l = base.viewWithTag(badgeTag) as? UILabel {
            return l
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: valueMaxSize.width, height: valueMaxSize.height))
        label.tag = badgeTag
        label.backgroundColor = .red
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1.0
        return label
    }
}
