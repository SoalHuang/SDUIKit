//
//  String+CICode.swift
//  SDUIKit
//
//  Created by soso on 2017/8/2.
//
//

import UIKit
import SDFoundation

public extension SDExtension where T == String {
    
    /// 条形码
    /// quiet space default is 7.0
    /// scale default is (3, 3)
    func barCodeImage(quietSpace: CGFloat = 7.0, scale: CGPoint = CGPoint(x: 3, y: 3)) -> UIImage? {
        guard
            let data = base.data(using: String.Encoding.ascii),
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            else {
                return nil
        }
        
        filter.setDefaults()
        filter.setValue(quietSpace, forKey: "inputQuietSpace")
        filter.setValue(data, forKey: "inputMessage")
        
        guard let output = filter.outputImage else {
            return nil
        }
        
        return UIImage(ciImage: output.transformed(by: CGAffineTransform(scaleX: scale.x, y: scale.y)))
    }
    
    /// 条形码
    /// quiet space default is 7.0
    /// scale default is (3, 3)
    func barCodeImage(quietSpace: CGFloat = 7.0, scale: CGPoint = CGPoint(x: 3, y: 3), _ completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let image = self.barCodeImage(quietSpace: quietSpace, scale: scale)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    /// 二维码
    /// size default is (200, 200)
    func qrCodeImage(_ size: CGSize = CGSize(width: 200, height: 200), logo: UIImage? = nil, logoSize: CGSize? = nil) -> UIImage? {
        guard
            let data = base.data(using: String.Encoding.utf8),
            let filter = CIFilter(name: "CIQRCodeGenerator")
            else {
                return nil
        }
        
        filter.setDefaults()
        filter.setValue("H", forKey: "inputCorrectionLevel")
        filter.setValue(data, forKey: "inputMessage")
        
        guard let output = filter.outputImage else {
            return nil
        }
        
        let scaleX = size.width / output.extent.size.width
        let scaleY = size.height / output.extent.size.height
        
        let image = UIImage(ciImage: output.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY)))
        
        guard let `logo` = logo, let `logoSize` = logoSize, logoSize.width > 0, logoSize.height > 0 else {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 2)
        
        image.draw(at: .zero)
        logo.draw(in: CGRect(x: (size.width - logoSize.width) * 0.5, y: (size.height - logoSize.height) * 0.5, width: logoSize.width, height: logoSize.height))
        
        let currentImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return currentImage ?? image
    }
    
    /// 二维码
    /// size default is (200, 200)
    func qrCodeImage(_ size: CGSize = CGSize(width: 200, height: 200), logo: UIImage? = nil, logoSize: CGSize? = nil, _ completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let image = self.qrCodeImage(size, logo: logo, logoSize: logoSize)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
