//
//  SDGuidePageView.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/21.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

extension SDGuidePageView {
    /**
     skipTitle: 跳过按钮的标题
     imageNames: 本地图片名称
     inView: 展示在哪个视图上
     force: 是否强制展示，不管是不是第一次
     dismiss: 消失前的回调
     */
    public class func show(skip title: String? = "立即体验",
                           images imageNames: [String]?,
                           in view: UIView,
                           force forceShow: Bool = false,
                           _ dismiss: (() -> ())?) -> Bool {
        guard let names = imageNames else {
            return false
        }
        if !forceShow {
            let version = Bundle.main.sd.version
            let didVersion = UserDefaults.standard.value(forKey: SDGuidePageView.storeKey) as? String
            if version == didVersion {
                return false
            }
        }
        view.endEditing(true)
        let guideView = SDGuidePageView(frame: UIScreen.main.bounds)
        guideView.skipTitle = title
        guideView.imageNames = names
        guideView.dismiss = dismiss
        guideView.pageControl.index = 0
        view.addSubview(guideView)
        return true
    }
}

@IBDesignable
open class SDGuidePageView: UIView {
    
    static let storeKey = "com.sd.guide"
    
    /// 留边
    @IBInspectable
    open var contentInsets: UIEdgeInsets = UIEdgeInsets.zero
    /// 间距
    @IBInspectable
    open var gap: CGSize = CGSize.zero
    
    /// 跳过按钮的标题
    open var skipTitle: String? {
        get { return enter.title(for: .normal) }
        set { enter.setTitle(newValue, for: .normal) }
    }
    
    /// 本地图片名称
    open var imageNames: [String] = [] {
        didSet {
            pageControl.totalCount = imageNames.count
            collectionView.reloadData()
        }
    }
    
    /// 消失前的回调
    open var dismiss: (() -> Void)?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(enter)
    }
    
    /// 重新布局
    open override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        pageControl.center = CGPoint(x: bounds.sd.centerX, y: bounds.height - 78)
        enter.center = CGPoint(x: bounds.sd.centerX, y: pageControl.sd.centerY)
    }
    
    /// 表格视图
    open lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.sectionInset = .zero
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.sd.registerClassWithCell(Cell.self)
        return cv
    }()
    
    /// 翻页指示器
    open lazy var pageControl: PageControl = {
        let view = PageControl(frame: CGSize(width: 300, height: 12).sd.bounds)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /// 进入按钮
    open lazy var enter: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 48))
        button.backgroundColor = UIColor(hex: 0x8b49f6)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("立即体验", for: .normal)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.masksToBounds = false
        button.sd.on(.touchUpInside) { [weak self] in self?.enterButtonAction($0) }
        button.alpha = 0
        return button
    }()
    
    /// 进入按钮的触发事件
    open func enterButtonAction(_ button: UIButton) {
        if let version = Bundle.main.sd.version {
            UserDefaults.standard.setValue(version, forKey: SDGuidePageView.storeKey)
            UserDefaults.standard.synchronize()
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }, completion: { (finished) in
            self.dismiss?()
            self.removeFromSuperview()
        })
    }
}

extension SDGuidePageView: UICollectionViewDelegateFlowLayout {
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sd.size
    }
}

extension SDGuidePageView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        offset.x = min(scrollView.contentSize.width - scrollView.sd.width, max(0, offset.x))
        scrollView.contentOffset = offset
        
        let ix = 0.5 + offset.x / scrollView.sd.width
        pageControl.index = Int(ix)
        
        let cut = 1.5 * scrollView.sd.width
        if offset.x < (scrollView.contentSize.width - cut) {
            enter.isHidden = true
            return
        }
        let less = offset.x - cut
        let p = less / (scrollView.sd.width / 2.0)
        
        enter.isHidden = false
        pageControl.alpha = 1.0 - p
        enter.alpha = p
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.sd.dequeueCell(Cell.self, for: indexPath)
        if let imageNamed = imageNames[safe: indexPath.item] {
            cell.imageView.image = UIImage(named: imageNamed)
        }
        return cell
    }
}

public extension SDGuidePageView {

    @IBDesignable
    class PageControl: UIView {
        
        /// 留边
        @IBInspectable
        open var contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        /// 间距
        @IBInspectable
        open var gap: CGSize = CGSize.zero
        
        public struct Block {
            public static var color = UIColor(hex: 0xcccccc)
            public static var tintColor = UIColor(hex: 0x8b49f6)
            public static var size: CGSize = 8.sd.size
        }
        
        public var totalCount: Int = 0 {
            didSet {
                blockViews.forEach { (vw) in vw.removeFromSuperview() }
                blockViews.removeAll()
                totalCount.sd.repeating { _ in
                    let v = UIView(frame: Block.size.sd.bounds)
                    v.backgroundColor = Block.color
                    addSubview(v)
                    blockViews.append(v)
                }
                index = min(max(0, totalCount - 1), index)
                setNeedsLayout()
            }
        }
        
        public var index: Int = -1 {
            didSet {
                if oldValue == index { return }
                if let oldVw = blockViews[safe: oldValue] {
                    UIView.animate(withDuration: 0.2, animations: {
                        oldVw.backgroundColor = Block.color
                        oldVw.transform = CGAffineTransform.identity
                    })
                }
                if let newVw = blockViews[safe: index] {
                    UIView.animate(withDuration: 0.2, animations: {
                        newVw.backgroundColor = Block.tintColor
                        newVw.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4.0)
                    })
                }
            }
        }
        
        public var blockViews = [UIView]()
        
        // MARK: Life cycle
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            gap = CGSize(width: 12, height: 0)
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            let inFrame = bounds.inset(by: contentInsets)
            let totalWidth = gap.width * CGFloat(max(0, totalCount - 1)) + CGFloat(totalCount) * Block.size.width
            var center_x = inFrame.sd.left + (inFrame.width - totalWidth) / 2.0 + Block.size.width / 2
            blockViews.forEach {
                $0.center = CGPoint(x: center_x, y: inFrame.sd.centerY)
                center_x += (gap.width + Block.size.width)
            }
        }
    }
}

public extension SDGuidePageView {
    
    class Cell : UICollectionViewCell {
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(imageView)
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            imageView.frame = bounds
        }
        
        public lazy var imageView: UIImageView = { UIImageView() }()
    }
}
