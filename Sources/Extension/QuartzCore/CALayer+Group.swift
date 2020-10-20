//
//  CALayer+Group.swift
//  TestDemo
//
//  Created by SoalHunag on 2019/6/20.
//  Copyright © 2019 SoalHunag. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

public extension CALayer {
    
    static var group_associated_key = "com.putao.animation.group.associated.key"
    private var groups: [String: AnimationGroup]? {
        get { return objc_getAssociatedObject(self, &CALayer.group_associated_key) as? [String : AnimationGroup] }
        set { objc_setAssociatedObject(self, &CALayer.group_associated_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func add(_ group: AnimationGroup, forKey key: String) {
        
        group.layer = self
        
        removeGroup(forKey: key)
        
        var currentGroups = groups ?? [:]
        currentGroups[key] = group
        groups = currentGroups
        
        group.run()
    }
    
    func removeAllGroups() {
        groups?.forEach { $0.value.cancel() }
        groups?.removeAll()
    }
    
    func removeGroup(forKey key: String) {
        group(forKey: key)?.cancel()
        groups?.removeValue(forKey: key)
    }
    
    func groupKeys() -> [String]? {
        return groups?.compactMap { $0.key }
    }
    
    func group(forKey key: String) -> AnimationGroup? {
        return groups?[key]
    }
}
