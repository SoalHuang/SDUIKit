//
//  QRScanner.swift
//  Bloks
//
//  Created by SoalHunag on 2018/10/12.
//  Copyright © 2018 soso. All rights reserved.
//

import UIKit
import AVFoundation

/// UIInterfaceOrientation -> AVCaptureVideoOrientation
extension UIInterfaceOrientation {
    
    var videoOrientation: AVCaptureVideoOrientation {
        switch self {
        case .unknown:              return .portrait
        case .portrait:             return .portrait
        case .portraitUpsideDown:   return .portraitUpsideDown
        case .landscapeLeft:        return .landscapeLeft
        case .landscapeRight:       return .landscapeRight
        @unknown default:
            print("Here is a new capture video orientation case")
            return .portrait
        }
    }
}

/// AVCaptureVideoOrientation -> UIInterfaceOrientation
extension AVCaptureVideoOrientation {
    
    var interfaceOrientation: UIInterfaceOrientation {
        switch self {
        case .portrait:             return .portrait
        case .portraitUpsideDown:   return .portraitUpsideDown
        case .landscapeLeft:        return .landscapeLeft
        case .landscapeRight:       return .landscapeRight
        @unknown default:
            print("Here is a new interface orientation case")
            return .portrait
        }
    }
}

// MARK: 扫码协议
public protocol QRScannerable: ViewableType {
    
    var session: AVCaptureSession { get }
    
    var animationView: QRScannerAnimationViewableType? { get set }
    
    var isRunning: Bool { get set }
    
    var isScanning: Bool { get set }
    
    var outputHandle: ((String) -> Void)? { get set }
    
    func attemptRotationToDeviceOrientation()
}

// MARK: 扫码协议的实现
extension QRScanner: QRScannerable {
    
    public var view: UIView! {
        return _renderView
    }
    
    public var session: AVCaptureSession {
        return _session
    }
    
    public var animationView: QRScannerAnimationViewableType? {
        get { return _animationView }
        set { _animationView = newValue }
    }
    
    public var isRunning: Bool {
        get { return session.isRunning }
        set {
            if isRunning == newValue { return }
            if newValue {
                session.startRunning()
            } else {
                session.stopRunning()
            }
        }
    }
    
    public var isScanning: Bool {
        get { return lock.sd.lock(_isScanning) }
        set {
            if lock.sd.lock(_isScanning) == newValue { return }
            lock.sd.lock(_isScanning = newValue)
            animationView?.isAnimting = newValue
        }
    }
    
    public var outputHandle: ((String) -> Void)? {
        get { return _handle }
        set { _handle = newValue }
    }
    
    public func attemptRotationToDeviceOrientation() {
        if let connection = videoPreviewLayer.connection, connection.isVideoOrientationSupported {
            connection.videoOrientation = UIApplication.shared.statusBarOrientation.videoOrientation
        }
    }
}

// MARK: 扫码的实现
public class QRScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    private var _session: AVCaptureSession
    
    private var _renderView: UIView
    
    private var _animationView: QRScannerAnimationViewableType? {
        didSet {
            oldValue?.removeFromSuper()
            if let avw = _animationView {
                avw.view.frame = _renderView.bounds
                _renderView.addSub(avw)
            }
        }
    }
    
    private var _isScanning: Bool = false
    
    private var _handle: ((String) -> Void)?
    
    private let lock = NSLock()
    
    public init(_ handle: ((String) -> Void)?) {
        _handle = handle
        _session = AVCaptureSession()
        _renderView = UIView(frame: UIScreen.main.bounds)
        super.init()
        
        videoPreviewLayer.frame = _renderView.layer.bounds
        _renderView.layer.addSublayer(videoPreviewLayer)
        
        lock.sd.lock(_isScanning = false)
        
        setup { [weak self] (successed) in
            guard successed else { return }
            self?.attemptRotationToDeviceOrientation()
            self?.isRunning = true
        }
    }
    
    private var needStop = true
    private lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }()
    
    func setup(_ completion: ((Bool) -> ())? = nil) {
        
        DispatchQueue.global().async { [weak self] in
            guard let `self` = self else { return }
            guard let captureDevice = AVCaptureDevice.default(for: .video) else {
                DispatchQueue.main.async { completion?(false) }
                return
            }
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                self.session.addInput(input)
            } catch {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    completion?(false)
                }
                return
            }
            let captureMetadataOutput = AVCaptureMetadataOutput()
            self.session.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
            DispatchQueue.main.async { completion?(true) }
        }
    }
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard
            lock.sd.lock(_isScanning),
            let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let text = metadataObj.stringValue else {
            return
        }
        lock.sd.lock(_isScanning = false)
        print("scan text:\(text)")
        _handle?(text)
    }
}


public protocol QRScannerAnimationViewableType: ViewableType {
    
    var focusSize: CGSize { get set }
    var focusImage: UIImage? { get set }
    var focusContentImage: UIImage? { get set }
    
    var isAnimting: Bool { get set }
}

extension QRScannerAnimationView: QRScannerAnimationViewableType {
    
    public var focusSize: CGSize {
        get { return _focusSize }
        set { _focusSize = newValue }
    }
    
    public var focusImage: UIImage? {
        get { return focusImageView.image }
        set { focusImageView.image = newValue }
    }
    
    public var focusContentImage: UIImage? {
        get { return focusContentImageView.image }
        set { focusContentImageView.image = newValue }
    }
    
    public var isAnimting: Bool {
        get { return _isAnimting }
        set { _isAnimting = newValue }
    }
}

public class QRScannerAnimationView: UIView {
    
    private var _focusSize: CGSize = CGSize(width: 240, height: 240)
    
    private var _isAnimting: Bool = false {
        didSet {
            if _isAnimting {
                focusContentImageView.image = nil
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(focusContentImageView)
        addSubview(focusImageView)
        
        layer.addSublayer(shapeLayer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        focusContentImageView.sd.layout {
            $0.size = _focusSize
            $0.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        }
        focusImageView.frame = focusContentImageView.frame
        
        updateShapePath()
    }
    
    private lazy var focusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    private lazy var focusContentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return shapeLayer
    }()
    
    private func updateShapePath() {
        let toLeftRight = ((bounds.width - _focusSize.width) / 2).sd.floor
        let toTopBottom = ((bounds.height - _focusSize.height) / 2).sd.floor
        
        let tpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: toTopBottom), cornerRadius: 0)
        let lpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: toLeftRight, height: bounds.height), cornerRadius: 0)
        let bpath = UIBezierPath(roundedRect: CGRect(x: 0, y: bounds.height - toTopBottom, width: bounds.width, height: toTopBottom), cornerRadius: 0)
        let rpath = UIBezierPath(roundedRect: CGRect(x: bounds.width - toLeftRight, y: 0, width: toLeftRight, height: bounds.height), cornerRadius: 0)
        
        let totalPath = UIBezierPath()
        totalPath.append(tpath)
        totalPath.append(lpath)
        totalPath.append(bpath)
        totalPath.append(rpath)
        
        shapeLayer.path = totalPath.cgPath
    }
}
