//
//  UILabel+Inspectable.h
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UILabel(Inspectable)

@property (assign, nonatomic) IBInspectable CGFloat textBorderWidth;
@property (strong, nonatomic, nullable) IBInspectable UIColor *textBorderColor;

@end

NS_ASSUME_NONNULL_END
