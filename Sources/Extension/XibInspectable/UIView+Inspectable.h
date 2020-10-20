//
//  UIView+Inspectable.h
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UIView(Inspectable)

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic, nullable) IBInspectable UIColor *borderColor;

@property (strong, nonatomic, nullable) IBInspectable UIColor *layerShadowColor;
@property (assign, nonatomic) IBInspectable CGSize layerShadowOffset;
@property (assign, nonatomic) IBInspectable float layerShadowOpacity;
@property (assign, nonatomic) IBInspectable CGFloat layerShadowRadius;

@end

NS_ASSUME_NONNULL_END
