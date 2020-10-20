//
//  SDSegmentControl.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/20.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

open class SDSegmentControl: UIScrollView {
    
    /// 选中的索引
    public private(set) var selectedIndex: Int = 0
    
    /// 展示可见的数量，可小数
    public var contentCount: CGFloat {
        get { return contentCount_ }
        set { contentCount_ = newValue; setNeedsLayout() }
    }
    
    /// 要展示的选项
    public var items: [Item] = [] {
        didSet {
            segments.forEach { $0.removeFromSuperview() }
            segments = items.compactMap {
                Button(item: $0).sd.on(.touchUpInside) { [weak self] in self?.action($0) }.base
            }
            segments.forEach { addSubview($0) }
            setNeedsLayout()
        }
    }
    
    /// 选中的回调
    public var selected: ((_ button: Button, _ index: Int) -> Bool)?
    
    /// 对应索引的按钮
    public func button(at index: Int) -> Button? {
        return segments[safe: index]
    }
    
    /// 选中指定索引的选项
    public func select(at index: Int, animated: Bool = true) {
        selectedIndex = index
        let size = sd.size
        let ctX = min(contentSize.width - size.width, max(0, (CGFloat(selectedIndex) + 0.5) * size.width / contentCount - size.width / 2))
        setContentOffset(CGPoint(x: ctX, y: contentOffset.y), animated: animated)
        segments.enumerated().forEach {
            $0.element.isDidHighlighted = index == $0.offset
        }
    }
    
    /// 绘制边框 (默认 style:bottom, lineWidth:1, lineColor:0x646464)
    public var drawBorder: ((SDCALayerBorder) -> Void)? = {
        $0.lineWidth = 1 / UIScreen.main.scale
        $0.lineColor = UIColor(hex: 0x646464)
        $0.style = [.bottom]
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        bounces = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let size = sd.size
        let count = CGFloat(items.count)
        contentCount_ = max(1, min(contentCount, count))
        let buttonSize = CGSize(width: size.width / contentCount, height: size.height)
        contentSize = CGSize(width: buttonSize.width * count, height: buttonSize.height)
        segments.enumerated().forEach {
            $0.element.frame = CGRect(x: buttonSize.width * CGFloat($0.offset), y: 0, width: buttonSize.width, height: buttonSize.height)
        }
        if let closure = drawBorder {
            layer.sd.border.make(closure)
        }
    }
    
    open override var contentSize: CGSize {
        didSet {
            if oldValue.equalTo(.zero), !contentSize.equalTo(.zero) {
                select(at: selectedIndex, animated: false)
            }
        }
    }
    
    private var contentCount_: CGFloat = 4
    private var segments: [Button] = []
    
    private func action(_ button: Button) {
        guard let `selected` = selected, let index = segments.firstIndex(of: button) else { return }
        if selected(button, index) {
            select(at: index, animated: true)
        }
    }
}


public extension SDSegmentControl {
    
    class Button: UIControl {
        
        public var isDidHighlighted: Bool = false {
            didSet {
                titleLabel.isHighlighted = isDidHighlighted
                imageView.isHighlighted = isDidHighlighted
                markView.backgroundColor = isDidHighlighted ? item.highlightedColor : item.color
            }
        }
        
        public var item: Item
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public init(item: Item) {
            self.item = item
            super.init(frame: .zero)
            addSubview(imageView)
            addSubview(titleLabel)
            addSubview(markView)
            markView.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi / 4)
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            imageView.frame = bounds
            titleLabel.frame = bounds.inset(by: item.titleEdgeInset)
            markView.center = CGPoint(x: titleLabel.sd.centerX, y: sd.height - 7)
        }
        
        public lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.text = item.title
            label.textColor = item.color
            label.highlightedTextColor = item.highlightedColor
            label.font = item.titleFont
            return label
        }()
        
        public lazy var imageView: UIImageView = {
            let image = UIImageView()
            image.image = item.image
            image.highlightedImage = item.highlightedImage
            return image
        }()
        
        public lazy var markView: UIView = { UIView(frame: 4.sd.square) }()
    }
    
    struct Item {
        public var title: String
        public var color: UIColor
        public var highlightedColor: UIColor
        public var titleFont: UIFont
        public var titleEdgeInset: UIEdgeInsets
        
        public var image: UIImage?
        public var highlightedImage: UIImage?
        
        public init(title: String,
                    color: UIColor = UIColor.black,
                    highlightedColor: UIColor = UIColor.gray,
                    titleFont: UIFont = UIFont.systemFont(ofSize: 14),
                    titleEdgeInset: UIEdgeInsets = .zero,
                    image: UIImage? = nil,
                    highlightedImage: UIImage? = nil) {
            self.title = title
            self.color = color
            self.highlightedColor = highlightedColor
            self.titleFont = titleFont
            self.titleEdgeInset = titleEdgeInset
            self.image = image
            self.highlightedImage = highlightedImage
        }
    }
}
