//
//  AnimationSequence.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/5/28.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit

public protocol AnimationSequenceDelegate: NSObjectProtocol {
    
    func sequence(_ sequence: AnimationSequence, animationDidStart anim: CAAnimation)
    func sequence(_ sequence: AnimationSequence, animationDidStop anim: CAAnimation, finished flag: Bool)
    func sequenceDidStart(_ sequence: AnimationSequence)
    func sequenceDidStop(_ sequence: AnimationSequence, finished flag: Bool)
}

extension AnimationSequenceDelegate {
    
    func sequence(_ sequence: AnimationSequence, animationDidStart anim: CAAnimation) { }
    func sequence(_ sequence: AnimationSequence, animationDidStop anim: CAAnimation, finished flag: Bool) { }
    func sequenceDidStart(_ sequence: AnimationSequence) { }
    func sequenceDidStop(_ sequence: AnimationSequence, finished flag: Bool) { }
}

open class AnimationSequence: NSObject {
    
    public typealias AnimationKey = String
    
    public enum Animation {
        case animation(CAAnimation, AnimationKey)
        case group(AnimationGroup, AnimationKey)
        case handle(() -> Void)
        case delay(TimeInterval)
    }
    
    open weak var delegate: AnimationSequenceDelegate?
    
    open var animations: [Animation]?
    
    open var isRemovedOnCompletion: Bool = false
    
    open var tag: Int = 0
    
    public enum HandleActionTypes {
        case start
        case stop(_ finished: Bool)
    }
    
    open var animationHandle: ((_ sequence: AnimationSequence, _ anim: CAAnimation, _ action: HandleActionTypes) -> Void)?
    open var handle: ((_ sequence: AnimationSequence, _ action: HandleActionTypes) -> Void)?
    
    internal weak var currentDelegate: CAAnimationDelegate?
    internal weak var currentGroupDelegate: AnimationGroupDelegate?
    
    open internal(set) weak var layer: CALayer?
    
    private var current: Int = 0
    
    private var isCanceled: Bool = false
    
    deinit {
        //print("AnimationSequence deinit")
    }
    
    public init(animations: [Animation]?) {
        super.init()
        self.animations = animations
    }
    
    internal func cancel() {
        isCanceled = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(next), object: nil)
        removeAllAnimations()
    }
    
    private func removeAllAnimations() {
        animations?.forEach {
            switch $0 {
            case .group(let group, _): group.cancel()
            case .animation(_, let key): layer?.removeAnimation(forKey: key)
            case .delay: break
            case .handle: break
            }
        }
    }
    
    internal func run() {
        
        currentDelegate = nil
        currentGroupDelegate = nil
        
        if isCanceled {
            delegate?.sequenceDidStop(self, finished: false)
            handle?(self, .stop(false))
            if isRemovedOnCompletion { removeAllAnimations() }
            return
        }
        
        guard let anim = animations?[safe: current] else {
            delegate?.sequenceDidStop(self, finished: true)
            handle?(self, .stop(true))
            if isRemovedOnCompletion { removeAllAnimations() }
            return
        }
        
        switch anim {
            
        case .animation(let ani, let key):
            currentDelegate = ani.delegate
            ani.delegate = self
            layer?.add(ani, forKey: key)
            
        case .group(let group, let key):
            currentGroupDelegate = group.delegate
            group.delegate = self
            layer?.add(group, forKey: key)
            
        case .handle(let closure):
            closure()
            next()
            
        case .delay(let sec):
            perform(#selector(next), with: nil, afterDelay: sec)
        }
    }
    
    @objc
    private func next() {
        current += 1
        run()
    }
}

extension AnimationSequence.Animation {
    
    public var tag: String {
        switch self {
        case .animation(let anim, _):   return "anim: \(anim.tag)"
        case .group(let group, _):      return "group: \(group.tag)"
        case .handle:                   return "closure"
        case .delay(let dt):            return "delay \(dt)s"
        }
    }
}

// MARK: - CAAnimationDelegate
extension AnimationSequence: CAAnimationDelegate {
    
    public func animationDidStart(_ anim: CAAnimation) {
        currentDelegate?.animationDidStart?(anim)
        delegate?.sequence(self, animationDidStart: anim)
        animationHandle?(self, anim, .start)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        currentDelegate?.animationDidStop?(anim, finished: flag)
        delegate?.sequence(self, animationDidStop: anim, finished: flag)
        animationHandle?(self, anim, .stop(flag))
        next()
    }
}

// MARK: - AnimationGroupDelegate
extension AnimationSequence: AnimationGroupDelegate {
    
    public func group(_ group: AnimationGroup, animationDidStart anim: AnimationGroup.Animation) {
        currentGroupDelegate?.group(group, animationDidStart: anim.0)
        animationHandle?(self, anim.0, .start)
    }
    
    public func group(_ group: AnimationGroup, animationDidStop anim: AnimationGroup.Animation, finished flag: Bool) {
        currentGroupDelegate?.group(group, animationDidStop: anim.0, finished: flag)
        animationHandle?(self, anim.0, .stop(flag))
    }
    
    public func groupDidStart(_ group: AnimationGroup) {
        currentGroupDelegate?.groupDidStart(group)
    }
    
    public func groupDidStop(_ group: AnimationGroup, finished flag: Bool) {
        currentGroupDelegate?.groupDidStop(group, finished: flag)
        next()
    }
}
