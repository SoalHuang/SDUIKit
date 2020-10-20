//
//  SDSceneView.swift
//  SceneDemo
//
//  Created by SoalHunag on 2018/9/28.
//  Copyright © 2018 soso. All rights reserved.
//

import UIKit
import SceneKit

public extension SCNView {
    
    /*!
     Format                         Filename Extension      Supported in
     Digital Asset Exchange         .dae                    macOS 10.8 and later
     Alembic                        .abc                    macOS 10.10 and later
     SceneKit compressed scene      .dae or .abc            macOS 10.10 and later
     SceneKit archive               .scn                    macOS 10.10 and later
     */
    enum Resource {
        case file(named: String, inDirectory: String? , options: [SCNSceneSource.LoadingOption : Any]?)
        case url(url: URL, options: [SCNSceneSource.LoadingOption : Any]?)
    }
    
    @discardableResult
    func loadScene(_ resource: Resource?) -> (SCNCamera?, SCNLight?, SCNLight?) {
        switch resource {
        case .file(let named, let inDirectory, let options)?:
            scene = SCNScene(named: named, inDirectory: inDirectory, options: options)
        case .url(let url, let options)?:
            scene = try? SCNScene(url: url, options: options)
        case .none: scene = nil
        }
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        
        scene?.rootNode.addChildNode(cameraNode)
        scene?.rootNode.addChildNode(lightNode)
        scene?.rootNode.addChildNode(ambientLightNode)
        
        return (cameraNode.camera, lightNode.light, ambientLightNode.light)
    }
}

public class SDSceneView: UIView {
    
    public var resource: SCNView.Resource? {
        didSet {
            switch resource {
            case .file(let named, let inDirectory, let options)?:
                scnView.scene = SCNScene(named: named, inDirectory: inDirectory, options: options)
            case .url(let url, let options)?:
                scnView.scene = try? SCNScene(url: url, options: options)
            case .none: scnView.scene = nil
            }
        }
    }
    
    public var scene: SCNScene? {
        get { return scnView.scene }
        set {
            cameraNode.removeFromParentNode()
            lightNode.removeFromParentNode()
            ambientLightNode.removeFromParentNode()
            
            scnView.scene = newValue
            
            scnView.scene?.rootNode.addChildNode(cameraNode)
            scnView.scene?.rootNode.addChildNode(lightNode)
            scnView.scene?.rootNode.addChildNode(ambientLightNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scnView)
        scnView.frame = bounds
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scnView.frame = bounds
    }
    
    public lazy var scnView: SCNView = {
        let scnView = SCNView()
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.clear
        scnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureHandleTap(_:))))
        return scnView
    }()
    
    public lazy var cameraNode: SCNNode = {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        return cameraNode
    }()
    
    public lazy var lightNode: SCNNode = {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        return lightNode
    }()
    
    public lazy var ambientLightNode: SCNNode = {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        return ambientLightNode
    }()
}

extension SDSceneView {
    
    @objc
    private func gestureHandleTap(_ gestureRecognize: UIGestureRecognizer) {
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        guard
            let result = hitResults.first,
            let material = result.node.geometry?.firstMaterial
            else { return }
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        SCNTransaction.completionBlock = {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            material.emission.contents = UIColor.black
            
            SCNTransaction.commit()
        }
        
        material.emission.contents = UIColor.red
        
        SCNTransaction.commit()
    }
}
