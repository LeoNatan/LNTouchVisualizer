//
//  LNTouchConfig.m
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import <LNTouchVisualizer/LNTouchConfig.h>

static const CGFloat LNTouchConfigContactAlpha = 0.5;
static const CGFloat LNTouchConfigRippleAlpha = 0.2;
static const NSTimeInterval LNTouchConfigContactFadeDuration = 0.3;
static const NSTimeInterval LNTouchConfigRippleFadeDuration = 0.2;

@implementation LNTouchConfig

- (instancetype)init
{
    self = [super init];
    
	if(self)
	{
		self.strokeColor = UIColor.labelColor;
		self.fillColor = UIColor.systemBackgroundColor;
		self.alpha = LNTouchConfigContactAlpha;
		self.fadeDuration = LNTouchConfigContactFadeDuration;
    }
    
	return self;
}

#pragma mark - Private

+ (LNTouchConfig *)touchConfig
{
	return [LNTouchConfig new];
}

+ (LNTouchConfig *)rippleConfig
{
	LNTouchConfig* rv = [LNTouchConfig new];
	
	rv.strokeColor = UIColor.systemBackgroundColor;
	rv.fillColor = UIColor.systemBlueColor;
	rv.alpha = LNTouchConfigRippleAlpha;
	rv.fadeDuration = LNTouchConfigRippleFadeDuration;
	
	return rv;
}

@end
