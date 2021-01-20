//
//  UIScreen+Brightness.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/7/23.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import ObjectiveC.runtime
import SDFoundation

public extension SDExtension where T: UIScreen {
    
    var scale: CGFloat {
        return scale(with: 667.0)
    }
    
    func scale(with target: CGFloat) -> CGFloat {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return base.bounds.width / target
        } else {
            return base.bounds.height / target
        }
    }
}

public extension SDExtension where T: UIScreen {
    
    @discardableResult
    func brightnessFade(to brightness: CGFloat, in timeInterval: TimeInterval = 0.5) -> SDExtension {
        base.brightness_fade(to: brightness, in: timeInterval)
        return self
    }
}

// MARK: UIScreen brightness fade
fileprivate extension UIScreen {
    
    //在timeInterval时间内把亮度调装为brightness
    func brightness_fade(to brightness: CGFloat, in timeInterval: TimeInterval = 0.5) {
        //差值
        let distance = brightness - self.brightness
        //相同，不需要调整
        if distance == 0 { return }
        //得到displayLink
        guard let link = displayLink(withTarget: self, selector: #selector(brightness_linkAction(_:))) else {
            return
        }
        //得到刷新帧率，默认60
        var framesPerSecond: Int = 60
        if #available(iOS 10.0, *) {
            framesPerSecond = link.preferredFramesPerSecond
        }
        //如果小于30，则固定为30
        if framesPerSecond < 30 {
            framesPerSecond = 30
        }
        //周期如果小于0，则固定为默认
        let timeInt = timeInterval > 0 ? timeInterval : UIScreen.brightnessDefaultTimeInt
        let step = distance / (CGFloat(framesPerSecond) * CGFloat(timeInt))
        //每次修改值如果为0，则结束
        if step == 0 {
            return
        }
        
        //如果存在未完成的link，则移除掉
        if let current_link = objc_getAssociatedObject(self, &UIScreen.brightnessLinkKey) as? CADisplayLink {
            brightness_removeLink(current_link)
        }
        
        //绑定link
        objc_setAssociatedObject(self, &UIScreen.brightnessLinkKey, link, .OBJC_ASSOCIATION_RETAIN)
        
        //将最终亮度值和每次修改的亮度值绑定到link上
        objc_setAssociatedObject(link, &UIScreen.brightnessKey, brightness, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(link, &UIScreen.brightnessStepKey, step, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        //将link添加进current RunLoop
        link.add(to: RunLoop.current, forMode: .common)
    }
    
    //link key
    private static var brightnessLinkKey = "com.sd.uikit.brightness.link"
    
    //最终的亮度值
    private static var brightnessKey = "com.sd.uikit.brightness.brightness"
    
    //每次修改的亮度值
    private static var brightnessStepKey = "com.sd.uikit.brightness.step"
    
    //默认周期
    private static let brightnessDefaultTimeInt: TimeInterval = 0.5
    
    private func brightness_removeLink(_ link: CADisplayLink) {
        //解除绑定
        objc_setAssociatedObject(self, &UIScreen.brightnessLinkKey, nil, .OBJC_ASSOCIATION_RETAIN)
        link.invalidate()
    }
    
    // displayLink 的回调
    @objc private func brightness_linkAction(_ link: CADisplayLink) {
        //取出 最终亮度值 和 每次修改的亮度值，未正确取出则结束
        guard
            let ness = objc_getAssociatedObject(link, &UIScreen.brightnessKey) as? CGFloat,
            let step = objc_getAssociatedObject(link, &UIScreen.brightnessStepKey) as? CGFloat
            else {
                brightness_removeLink(link)
                return
        }
        //亮度值加过或减过最终值，则结束
        if (step >= 0 && brightness >= ness) || (step <= 0 && brightness <= ness) {
            brightness_removeLink(link)
            return
        }
        //继续增加或减少亮度值
        brightness += step
    }
}
