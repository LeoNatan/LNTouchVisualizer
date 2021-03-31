//
//  LNTouchImageFactory.m
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import "LNTouchImageFactory.h"
#import <LNTouchVisualizer/LNTouchConfig.h>

static const CGFloat LNTouchImageFactorySideSize = 50.0;

@implementation LNTouchImageFactory

+ (UIImage*)imageWithTouchConfig:(LNTouchConfig *)touchConfig
{
	UIImage *image = [UIImage new];
	UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, LNTouchImageFactorySideSize, LNTouchImageFactorySideSize)];
	UIGraphicsBeginImageContextWithOptions(clipPath.bounds.size, NO, 0);
	CGPoint center = CGPointMake(LNTouchImageFactorySideSize / 2.0, LNTouchImageFactorySideSize / 2.0);
	
	UIBezierPath *drawPath = [UIBezierPath bezierPathWithArcCenter:center radius:22.0 startAngle:0 endAngle:2 * M_PI clockwise:YES];
	drawPath.lineWidth = 3.0;
	
	[touchConfig.strokeColor setStroke];
	[touchConfig.fillColor setFill];
	
	[drawPath stroke];
	[drawPath fill];
	[clipPath addClip];
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    return image;
}

@end
