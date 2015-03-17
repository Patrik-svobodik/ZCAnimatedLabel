//
//  ZCTurnAroundLabel.m
//  ZCAnimatedLabel
//
//  Created by Chen Zhang on 2/26/15.
//  Copyright (c) 2015 somewhere. All rights reserved.
//

#import "ZCThrownLabel.h"
#import "ZCEasingUtil.h"

@implementation ZCThrownLabel

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.onlyDrawDirtyArea = YES;
    }
    return self;
}

- (CGRect) customRedrawAreaWithRect:(CGRect)rect attribute:(ZCTextBlock *)attribute
{
    CGRect charRect = attribute.charRect;
    return CGRectMake(0, 0, CGRectGetMaxX(charRect), CGRectGetMaxY(charRect));
}

- (void) customAppearDrawingForRect: (CGRect) rect attribute: (ZCTextBlock *) attribute
{
    CGFloat realProgress = [ZCEasingUtil bounceWithStiffness:0.01 numberOfBounces:1 time:attribute.progress shake:NO shouldOvershoot:NO];
    if (realProgress < 0.01) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 0.2 + 0.8 * realProgress, 0.2 + 0.8 * realProgress);
    UIColor *color = [attribute.derivedTextColor colorWithAlphaComponent:realProgress];

    attribute.textColor = color;
    [attribute.derivedAttributedString drawInRect:attribute.charRect];;
    CGContextRestoreGState(context);
}


@end