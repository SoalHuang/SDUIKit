//
//  UILabel+Inspectable.m
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/8.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

#import "UILabel+Inspectable.h"
#import <objc/runtime.h>

@implementation UILabel(Inspectable)

static void *textBorderWidthKey = 0;
static void *textBorderColorKey = 0;

+ (void)load {
    Method original = class_getInstanceMethod(self, @selector(drawTextInRect:));
    Method newMethod = class_getInstanceMethod(self, @selector(textBorderDrawTextInRect:));
    if (original && newMethod) {
        method_exchangeImplementations(original, newMethod);
    }
}

- (CGFloat)textBorderWidth {
    return ((NSNumber *)objc_getAssociatedObject(self, &textBorderWidthKey)).doubleValue;
}

- (void)setTextBorderWidth:(CGFloat)textBorderWidth {
    objc_setAssociatedObject(self, &textBorderWidthKey, @(textBorderWidth), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsDisplay];
}

- (nullable UIColor *)textBorderColor {
    return objc_getAssociatedObject(self, &textBorderColorKey);
}

- (void)setTextBorderColor:(nullable UIColor *)textBorderColor {
    objc_setAssociatedObject(self, &textBorderColorKey, textBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (void)textBorderDrawTextInRect:(CGRect)rect {
    CGFloat bw = [self textBorderWidth];
    UIColor *bc = [self textBorderColor];
    if (bw <= 0 || bc == nil) {
        [self textBorderDrawTextInRect:rect];
        return;
    }
    
    CGSize tempOffset = self.shadowOffset;
    UIColor *tempColor = self.textColor;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, bw);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(ctx, kCGTextStroke);
    self.textColor = bc;
    [self textBorderDrawTextInRect:rect];
    
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    self.textColor = tempColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [self textBorderDrawTextInRect:rect];
    
    self.shadowOffset = tempOffset;
}

@end
