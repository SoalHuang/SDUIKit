//
//  UIImage+CICode.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/9/17.
//  Copyright © 2018 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UIImage {
    
    var qrCodes: [String] {
        guard let ciImage = CIImage(image: base) else { return [] }
        let context = CIContext()
        var options: [String: Any] = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
        if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
            options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
        } else {
            options = [CIDetectorImageOrientation: 1]
        }
        guard let features = qrDetector?.features(in: ciImage, options: options) else {
            return []
        }
        return features.compactMap {
            guard let text = ($0 as? CIQRCodeFeature)?.messageString else { return nil }
            return text.isEmpty ? nil : text
        }
    }
}
