//
//  UIButton+Inspectable.h
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UIButton(Inspectable)

@property (assign, nonatomic) IBInspectable CGFloat textBorderWidth;
@property (strong, nonatomic, nullable) IBInspectable UIColor *textBorderColor;

@property (strong, nonatomic, nullable) IBInspectable UIImage *disImage;
@property (strong, nonatomic, nullable) IBInspectable UIImage *higImage;
@property (strong, nonatomic, nullable) IBInspectable UIImage *selImage;

@property (strong, nonatomic, nullable) IBInspectable UIImage *bgDisImage;
@property (strong, nonatomic, nullable) IBInspectable UIImage *bgHigImage;
@property (strong, nonatomic, nullable) IBInspectable UIImage *bgSelImage;

@end

NS_ASSUME_NONNULL_END
