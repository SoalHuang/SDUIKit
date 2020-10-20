//
//  AnimationGroup.swift
//  TestDemo
//
//  Created by SoalHunag on 2019/6/20.
//  Copyright © 2019 SoalHunag. All rights reserved.
//

import UIKit

public protocol AnimationGroupDelegate: NSObjectProtocol {
    
    func group(_ group: AnimationGroup, animationDidStart anim: CAAnimation)
    func group(_ group: AnimationGroup, animationDidStop anim: CAAnimation, finished flag: Bool)
    func groupDidStart(_ group: AnimationGroup)
    func groupDidStop(_ group: AnimationGroup, finished flag: Bool)
}

public extension AnimationGroupDelegate {
    
    func group(_ group: AnimationGroup, animationDidStart anim: CAAnimation) { }
    func group(_ group: AnimationGroup, animationDidStop anim: CAAnimation, finished flag: Bool) { }
    func groupDidStart(_ group: AnimationGroup) { }
    func groupDidStop(_ group: AnimationGroup, finished flag: Bool) { }
}

public class AnimationGroup: NSObject {
    
    public typealias AnimationKey = String
    
    public typealias Animation = (CAAnimation, AnimationKey)
    
    public weak var delegate: AnimationGroupDelegate?
    
    open var animations: [Animation]?
    
    open var isRemovedOnCompletion: Bool = false
    
    open var tag: Int = 0
    
    public enum HandleActionTypes {
        case start
        case stop(_ finished: Bool)
    }
    
    open var animationHandle: ((_ group: AnimationGroup, _ anim: CAAnimation, _ action: HandleActionTypes) -> Void)?
    open var handle: ((_ group: AnimationGroup, _ action: HandleActionTypes) -> Void)?
    
    public internal(set) weak var layer: CALayer?
    
    private var completionCount: Int = 0
    
    deinit {
        //print("AnimationGroup deinit")
    }
    
    public init(animations: [Animation]?) {
        super.init()
        self.animations = animations
    }
    
    internal func cancel() {
        animations?.enumerated().forEach {
            layer?.removeAnimation(forKey: $0.element.1)
        }
    }
    
    internal func run() {
        animations?.enumerated().forEach {
            $0.element.0.delegate = self
            layer?.add($0.element.0, forKey: $0.element.1)
        }
    }
}

// MARK: - CAAnimationDelegate
extension AnimationGroup: CAAnimationDelegate {
    
    public func animationDidStart(_ anim: CAAnimation) {
        
        if completionCount == 0 {
            delegate?.groupDidStart(self)
            handle?(self, .start)
        }
        
        completionCount += 1
        
        delegate?.group(self, animationDidStart: anim)
        animationHandle?(self, anim, .start)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        delegate?.group(self, animationDidStop: anim, finished: flag)
        
        handle?(self, .stop(flag))
        
        guard completionCount == animations?.count else { return }
        
        delegate?.groupDidStop(self, finished: flag)
        
        animationHandle?(self, anim, .stop(flag))
    }
}
