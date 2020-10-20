//
//  UIView+Inspectable.m
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Inspectable.h"

@implementation UIView(Inspectable)

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (nullable UIColor *)borderColor {
    if (self.layer.borderColor == nil) {
        return nil;
    }
    return [UIColor colorWithCGColor: self.layer.borderColor];
}

- (void)setBorderColor:(nullable UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (nullable UIColor *)layerShadowColor {
    if (self.layer.shadowColor == nil) {
        return nil;
    }
    return [UIColor colorWithCGColor: self.layer.shadowColor];
}

- (void)setLayerShadowColor:(nullable UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (CGSize)layerShadowOffset {
    return self.layer.shadowOffset;
}

- (void)setLayerShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (float)layerShadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setLayerShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)layerShadowRadius {
    return self.layer.shadowRadius;
}

- (void)setLayerShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

@end
