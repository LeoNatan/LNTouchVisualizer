//
//  LNTouchConfig.m
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import "LNTouchConfig.h"

static const CGFloat LNTouchConfigContactAlpha = 0.5;
static const CGFloat LNTouchConfigRippleAlpha = 0.2;
static const NSTimeInterval LNTouchConfigContactFadeDuration = 0.3;
static const NSTimeInterval LNTouchConfigRippleFadeDuration = 0.2;

@implementation LNTouchConfig

- (instancetype)initWithTouchConfigType:(LNTouchConfigTpye)configType
{
    self = [super init];
    
	if (self)
	{
        switch (configType)
		{
            case LNTouchConfigTpyeContact:
                [self _configureContact];
                break;
            case LNTouchConfigTpyeRipple:
                [self _configureRipple];
                break;
        }
    }
    
	return self;
}

#pragma mark - Private

- (void)_configureContact
{
    self.strokeColor = UIColor.labelColor;
    self.fillColor = UIColor.systemBackgroundColor;
    self.alpha = LNTouchConfigContactAlpha;
    self.fadeDuration = LNTouchConfigContactFadeDuration;
}

- (void)_configureRipple
{
    self.strokeColor = UIColor.systemBackgroundColor;
    self.fillColor = UIColor.systemBlueColor;
    self.alpha = LNTouchConfigRippleAlpha;
    self.fadeDuration = LNTouchConfigRippleFadeDuration;
}

@end
