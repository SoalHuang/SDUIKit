//
//  CircleProgressView.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import UIKit

public extension CircleProgressView {
    
    override var backgroundColor: UIColor? {
        get { return progressLayer.circleColor }
        set { progressLayer.circleColor = newValue ?? UIColor.clear }
    }
    
    var startColor: UIColor {
        get { return progressLayer.startColor }
        set { progressLayer.startColor = newValue }
    }
    
    var endColor: UIColor {
        get { return progressLayer.endColor }
        set { progressLayer.endColor = newValue }
    }
    
    var startAngle: CGFloat {
        get { return progressLayer.startAngle }
        set { progressLayer.startAngle = newValue }
    }
    
    var lineWidth: CGFloat {
        get { return progressLayer.lineWidth }
        set { progressLayer.lineWidth = newValue }
    }
    
    var progress: CGFloat {
        get { return progressLayer.progress }
        set { progressLayer.progress = newValue }
    }
}

public class CircleProgressView: UIView {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(progressLayer)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = bounds
    }
    
    private lazy var progressLayer: CircleProgressView.ContentLayer = CircleProgressView.ContentLayer()
}

extension CircleProgressView {
    
    class ContentLayer: CALayer {
        
        var circleColor: UIColor = UIColor.lightGray {
            didSet {
                backgroundCircleLayer.borderColor = circleColor.cgColor
            }
        }
        
        var startColor: UIColor = UIColor.green {
            didSet {
                gradientBackgroundLayer.backgroundColor = startColor.cgColor
                gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            }
        }
        
        var endColor: UIColor = UIColor.red {
            didSet {
                gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            }
        }
        
        var startAngle: CGFloat = -CGFloat.pi / 2 {
            didSet { render() }
        }
        
        var lineWidth: CGFloat = 4 {
            didSet {
                backgroundCircleLayer.borderWidth = lineWidth
                gradientBackgroundMaskLayer.lineWidth = lineWidth
                gradientMaskLayer.lineWidth = lineWidth
                render()
            }
        }
        
        var progress: CGFloat = 0 {
            didSet { render() }
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupSublayers()
        }
        
        override init() {
            super.init()
            setupSublayers()
        }
        
        override init(layer: Any) {
            super.init(layer: layer)
            setupSublayers()
        }
        
        private func setupSublayers() {
            addSublayer(backgroundCircleLayer)
            
            addSublayer(gradientBackgroundLayer)
            addSublayer(gradientContentLayer)
            
            gradientContentLayer.addSublayer(gradientLayer)
            
            gradientBackgroundLayer.mask = gradientBackgroundMaskLayer
            gradientLayer.mask = gradientMaskLayer
            gradientContentLayer.mask = gradientContentMaskLayer
        }
        
        override func layoutSublayers() {
            super.layoutSublayers()
            backgroundCircleLayer.frame = bounds
            backgroundCircleLayer.cornerRadius = min(backgroundCircleLayer.bounds.width, backgroundCircleLayer.bounds.height) / 2.0
            gradientBackgroundLayer.frame = bounds
            gradientContentLayer.frame = bounds
            gradientLayer.frame = gradientContentLayer.bounds
            gradientContentMaskLayer.frame = gradientContentLayer.bounds
        }
        
        private lazy var backgroundCircleLayer: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.clear.cgColor
            layer.borderColor = circleColor.cgColor
            layer.borderWidth = lineWidth
            return layer
        }()
        
        private lazy var gradientBackgroundLayer: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = startColor.cgColor
            return layer
        }()
        
        private lazy var gradientBackgroundMaskLayer: CAShapeLayer = {
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.lineCap = .round
            return shapeLayer
        }()
        
        private lazy var gradientContentLayer = CALayer()
        
        private lazy var gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [startColor.cgColor, endColor.cgColor]
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
            return layer
        }()
        
        private lazy var gradientMaskLayer: CAShapeLayer = {
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.lineCap = .round
            return shapeLayer
        }()
        
        private lazy var gradientContentMaskLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
            layer.locations = [NSNumber(value: 0.2), NSNumber(value: 0.8)]
            layer.startPoint = CGPoint(x: 1.0, y: 0.5)
            layer.endPoint = CGPoint(x: 0.0, y: 0.5)
            return layer
        }()
        
        private func render() {
            let bounds = gradientLayer.bounds
            let borderWidth = lineWidth / 2
            
            let insetRect = bounds.inset(by: borderWidth.sd.insets)
            
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let radius = min(insetRect.width, insetRect.height) / 2
            let start = startAngle
            let end = start + CGFloat.pi * 2 * progress
            
            let gradientStart = max(end - CGFloat.pi, start)
            
            let startPoint = CGPoint(x: (cos(gradientStart) + 1) / 2.0, y: (sin(gradientStart) + 1) / 2.0)
            let endPoint = CGPoint(x: (cos(end) + 1) / 2.0, y: (sin(end) + 1) / 2.0)
            
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            
            let gradientBackgroundPath = CGMutablePath()
            gradientBackgroundPath.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: false)
            gradientBackgroundMaskLayer.path = gradientBackgroundPath
            
            let gradientPath = CGMutablePath()
            gradientPath.addArc(center: center, radius: radius, startAngle: gradientStart, endAngle: end, clockwise: false)
            gradientMaskLayer.path = gradientPath
            
            gradientContentMaskLayer.startPoint = startPoint
            gradientContentMaskLayer.endPoint = endPoint
        }
    }
}
