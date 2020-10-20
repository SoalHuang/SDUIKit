//
//  UIButton+Inspectable.m
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

#import "UIButton+Inspectable.h"
#import "UILabel+Inspectable.h"

@implementation UIButton(Inspectable)

- (CGFloat)textBorderWidth {
    if (self.titleLabel == nil) {
        return 0;
    }
    return self.titleLabel.textBorderWidth;
}

- (void)setTextBorderWidth:(CGFloat)textBorderWidth {
    self.titleLabel.textBorderWidth = textBorderWidth;
}

- (nullable UIColor *)textBorderColor {
    if (self.titleLabel == nil) {
        return nil;
    }
    return self.titleLabel.textBorderColor;
}

- (void)setTextBorderColor:(nullable UIColor *)textBorderColor {
    self.titleLabel.textBorderColor = textBorderColor;
}

- (nullable UIImage *)disImage {
    return [self imageForState: UIControlStateDisabled];
}

- (void)setDisImage:(nullable UIImage *)disImage {
    [self setImage: disImage forState: UIControlStateDisabled];
}

- (nullable UIImage *)higImage {
    return [self imageForState: UIControlStateHighlighted];
}

- (void)setHigImage:(nullable UIImage *)higImage {
    [self setImage: higImage forState: UIControlStateHighlighted];
}

- (nullable UIImage *)selImage {
    return [self imageForState: UIControlStateSelected];
}

- (void)setSelImage:(nullable UIImage *)selImage {
    [self setImage: selImage forState: UIControlStateSelected];
}

- (nullable UIImage *)bgDisImage {
    return [self backgroundImageForState: UIControlStateDisabled];
}

- (void)setBgDisImage:(nullable UIImage *)bgDisImage {
    [self setBackgroundImage: bgDisImage forState: UIControlStateDisabled];
}

- (nullable UIImage *)bgHigImage {
    return [self backgroundImageForState: UIControlStateHighlighted];
}

- (void)setBgHigImage:(nullable UIImage *)bgHigImage {
    [self setBackgroundImage: bgHigImage forState: UIControlStateHighlighted];
}

- (nullable UIImage *)bgSelImage {
    return [self backgroundImageForState: UIControlStateSelected];
}

- (void)setBgSelImage:(nullable UIImage *)bgSelImage {
    [self setBackgroundImage: bgSelImage forState: UIControlStateSelected];
}

@end
