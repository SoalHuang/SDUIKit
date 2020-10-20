//
//  SDPopupMenu.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/19.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit

public struct SDPopupItem<Element> {
    
    public var backgroundColor: UIColor?
    public var icon: UIImage?
    public var attributedText: NSAttributedString
    public var height: CGFloat = 44
    public var content: Element?
    internal var action: ((SDPopupItem<Element>) -> Void)?
    
    public init(backgroundColor: UIColor? = nil,
                icon: UIImage? = nil,
                attributedText: NSAttributedString,
                height: CGFloat = 44,
                content: Element? = nil,
                action: ((SDPopupItem<Element>) -> Void)? = nil) {
        self.backgroundColor = backgroundColor
        self.icon = icon
        self.attributedText = attributedText
        self.height = height
        self.content = content
        self.action = action
    }
}

public class SDPopupItemView<Element>: UIControl {
    
    internal var item: SDPopupItem<Element>?
    
    internal var action: ((SDPopupItem<Element>?) -> Void)?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal init(item: SDPopupItem<Element>) {
        self.item = item
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: item.height))
        addSubview(imageView)
        addSubview(textLabel)
        backgroundColor = item.backgroundColor ?? UIColor.white
        if let image = item.icon {
            imageView.image = image
        }
        textLabel.attributedText = item.attributedText
        addTarget(self, action: #selector(itemTouchUpInside), for: .touchUpInside)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let inFrame = bounds.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        guard let _ = imageView.image else {
            textLabel.frame = inFrame
            return
        }
        imageView.frame = CGRect(x: inFrame.minX, y: inFrame.minY, width: inFrame.height, height: inFrame.height)
        textLabel.frame = inFrame.inset(by: UIEdgeInsets(top: 0, left: imageView.frame.width + 10, bottom: 0, right: 0))
    }
    
    private lazy var imageView: UIImageView = { UIImageView() }()
    private lazy var textLabel: UILabel = { UILabel() }()
    
    @objc private func itemTouchUpInside() {
        action?(item)
    }
}

public class SDPopupBackgroundView: UIControl {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(selfTouchUpInside), for: .touchUpInside)
    }
    
    @objc private func selfTouchUpInside() {
        self.removeFromSuperview()
    }
}

public class SDPopupMenu<Element> {
    
    public init(items: [SDPopupItem<Element>]? = nil, contentWidth: CGFloat) {
        if let its = items { self.items.append(contentsOf: its) }
        self.contentWidth = contentWidth
    }
    
    public func addItem(backgroundColor: UIColor? = nil,
                                 icon: UIImage? = nil,
                                 attributedText: NSAttributedString,
                                 height: CGFloat = 44,
                                 content: Element? = nil,
                                 action: ((SDPopupItem<Element>) -> Void)? = nil) {
        let item = SDPopupItem(backgroundColor: backgroundColor,
                                 icon: icon,
                                 attributedText: attributedText,
                                 height: height,
                                 content: content,
                                 action: action)
        addItem(item)
    }
    
    public func addItem(_ item: SDPopupItem<Element>) {
        items.append(item)
    }
    
    public func popup(in parent: UIView, at position: CGPoint, gap: CGSize = CGSize(width: 15, height: 15)) {
        
        parent.addSubview(backgroundView)
        backgroundView.frame = parent.bounds
        backgroundView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth.union(.flexibleHeight)
        
        shadowView.sd.layout { $0.size = CGSize(width: contentWidth, height: items.reduce(0) { $0 + $1.height } ) }
        
        let cx = max(gap.width, min(backgroundView.bounds.width - gap.width - shadowView.bounds.width, position.x))
        let cy = max(gap.height, min(backgroundView.bounds.height - gap.height - shadowView.bounds.height, position.y))
        shadowView.center = CGPoint(x: cx + shadowView.bounds.width / 2, y: cy + shadowView.bounds.height / 2)
        
        backgroundView.addSubview(shadowView)
        
        let radius: CGFloat = 6
        shadowView.layer.shadowRadius = radius
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: .all, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        shadowView.layer.shouldRasterize = true
        
        contentView.frame = shadowView.frame
        backgroundView.addSubview(contentView)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = radius
        
        var y: CGFloat = 0
        items.forEach {
            let itemView = SDPopupItemView(item: $0)
            itemView.frame = CGRect(x: 0, y: y, width: contentWidth, height: $0.height)
            contentView.addSubview(itemView)
            itemViews.append(itemView)
            itemView.action = { [weak backgroundView] (item) in
                guard let item = item else { return }
                item.action?(item)
                backgroundView?.removeFromSuperview()
            }
            y += $0.height
        }
    }
    
    private var contentWidth: CGFloat = 100
    private var items: [SDPopupItem<Element>] = []
    
    public private(set) var itemViews: [SDPopupItemView<Element>] = []
    public private(set) lazy var backgroundView: SDPopupBackgroundView = { SDPopupBackgroundView() }()
    public private(set) lazy var shadowView: UIView = { UIView() }()
    public private(set) lazy var contentView: UIView = { UIView() }()
}
