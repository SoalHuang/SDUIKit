//
//  CALayer+Border.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/3/12.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import ObjectiveC.runtime
import SDFoundation

public extension SDExtension where T: CALayer {
    
    /// 边框 & 边角
    var border: SDBorderProxy { return SDBorderProxy(self.base) }
}

public struct SDBorderProxy {
    
    static private var key: String = "SD.CALayer.Border.Key"
    
    private var base: CALayer
    fileprivate init(_ base: CALayer) {
        self.base = base
    }
    
    /// 添加边框、边角
    public func make(_ closure: (SDCALayerBorder) -> ()) {
        if let currentBorder = objc_getAssociatedObject(base, &SDBorderProxy.key) as? SDCALayerBorder {
            closure(currentBorder)
            currentBorder.setNeedsDisplay()
        } else {
            let newBorder = SDCALayerBorder(base)
            objc_setAssociatedObject(base, &SDBorderProxy.key, newBorder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            closure(newBorder)
            newBorder.setNeedsDisplay()
        }
    }
    
    /// 清除
    public func clear() {
        (objc_getAssociatedObject(base, &SDBorderProxy.key) as? SDCALayerBorder)?.clear()
        objc_setAssociatedObject(base, &SDBorderProxy.key, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

public extension UIRectCorner {
    
    static let none      = UIRectCorner([])
    static let top       = UIRectCorner.topLeft.union(UIRectCorner.topRight)
    static let left      = UIRectCorner.topLeft.union(UIRectCorner.bottomLeft)
    static let bottom    = UIRectCorner.bottomLeft.union(UIRectCorner.bottomRight)
    static let right     = UIRectCorner.topRight.union(UIRectCorner.bottomRight)
    static let all       = UIRectCorner.top.union(UIRectCorner.bottom)
    static let topLeftBottomRight    = UIRectCorner.topLeft.union(UIRectCorner.bottomRight)
    static let topRightBottomLeft    = UIRectCorner.topRight.union(UIRectCorner.bottomLeft)
}

/// 边框 & 边角
public class SDCALayerBorder: NSObject, CALayerDelegate {
    
    public enum BorderStyle: Int, CaseIterable {
        case top        = 1
        case left       = 2
        case bottom     = 3
        case right      = 4
        public static let all: [BorderStyle] = [.top, .left, .bottom, .right]
    }
    
    /// 边框样式
    public var style:[BorderStyle] = []
    /// 边角样式
    public var corner: UIRectCorner = UIRectCorner(rawValue: 0)
    /// 边角大小
    public var radius: CGFloat = 0
    /// 边框线宽
    public var lineWidth: CGFloat = 0
    /// 边框颜色
    public var lineColor: UIColor = UIColor.black
    
    private weak var targetLayer: CALayer?
    private let drawLayer: CALayer = CALayer()

    public required init(_ base: CALayer?) {
        super.init()
        targetLayer = base
        drawLayer.frame = base?.bounds ?? .zero
        base?.addSublayer(drawLayer)
        drawLayer.delegate = self
    }
    
    fileprivate func clear() {
        drawLayer.delegate = nil
        drawLayer.removeFromSuperlayer()
        maskLayer.removeFromSuperlayer()
    }
    
    fileprivate func setNeedsDisplay() {
        guard let `targetLayer` = targetLayer else { return }
        drawLayer.frame = targetLayer.bounds
        drawLayer.setNeedsDisplay()
        guard radius > 0 else { return }
        let maskPath = UIBezierPath(roundedRect: targetLayer.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        maskLayer.frame = targetLayer.bounds
        maskLayer.path = maskPath.cgPath
        targetLayer.mask = maskLayer
    }

    private lazy var maskLayer: CAShapeLayer = {
        $0.backgroundColor = UIColor.clear.cgColor
        return $0
    }(CAShapeLayer())
    
    // MARK: CALayerDelegate
    public func draw(_ layer: CALayer, in ctx: CGContext) {
        guard let _ = targetLayer else { return }
        let linePath = SDCALayerBorder.borderLinePath(size: drawLayer.bounds.size, style: style, corner: corner, cornerRadii: CGSize(width: radius, height: radius))
        linePath.lineWidth = lineWidth
        if !linePath.isEmpty {
            ctx.setFillColor(UIColor.clear.cgColor)
            ctx.fillPath()
            ctx.setLineWidth(lineWidth)
            ctx.setStrokeColor(lineColor.cgColor)
            ctx.addPath(linePath.cgPath)
            ctx.strokePath()
        }
    }
}

private extension SDCALayerBorder {
    
    private class func borderLinePath(size: CGSize,
                                style: [BorderStyle],
                                corner: UIRectCorner?,
                                cornerRadii: CGSize) -> UIBezierPath {
        let path = UIBezierPath()
        if style.contains(.top) {
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: size.width, y: 0))
        }
        if style.contains(.right) {
            path.move(to: CGPoint(x: size.width, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: size.height))
        }
        if style.contains(.bottom) {
            path.move(to: CGPoint(x: size.width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
        }
        if style.contains(.left) {
            path.move(to: CGPoint(x: 0, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        guard let `corner` = corner else {
            return path
        }
        let controlOffset: CGFloat = 1
        if corner.contains(.topLeft), style.contains(.top), style.contains(.left) {
            path.move(to: CGPoint(x: 0, y: cornerRadii.height))
            path.addQuadCurve(to: CGPoint(x: cornerRadii.width, y: 0), controlPoint: CGPoint(x: controlOffset, y: controlOffset))
        }
        if corner.contains(.topRight), style.contains(.top), style.contains(.right) {
            path.move(to: CGPoint(x: size.width - cornerRadii.width, y: 0))
            path.addQuadCurve(to: CGPoint(x: size.width, y: cornerRadii.height), controlPoint: CGPoint(x: size.width - controlOffset, y: controlOffset))
        }
        if corner.contains(.bottomLeft), style.contains(.bottom), style.contains(.left) {
            path.move(to: CGPoint(x: cornerRadii.width, y: size.height))
            path.addQuadCurve(to: CGPoint(x: 0, y: size.height - cornerRadii.height), controlPoint: CGPoint(x: controlOffset, y: size.height - controlOffset))
        }
        if corner.contains(.bottomRight), style.contains(.bottom), style.contains(.right) {
            path.move(to: CGPoint(x: size.width, y: size.height - cornerRadii.height))
            path.addQuadCurve(to: CGPoint(x: size.width - cornerRadii.width, y: size.height), controlPoint: CGPoint(x: size.width - controlOffset, y: size.height - controlOffset))
        }
        return path
    }
}
