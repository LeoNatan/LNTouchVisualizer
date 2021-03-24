//
//  LNTouchVisualizerWindow.h
//  TouchVisualizer
//
//  Created by Joe Blau on 3/22/14.
//  Copyright (c) 2014 conopsys. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <LNTouchVisualizer/LNTouchConfig.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LNTouchVisualizerWindowTouchVisibility)
{
    LNTouchVisualizerWindowTouchVisibilityNever,
    LNTouchVisualizerWindowTouchVisibilityRemoteOnly,
    LNTouchVisualizerWindowTouchVisibilityRemoteAndLocal,
};

@interface LNTouchVisualizerWindow : UIWindow

@property (nonatomic, getter=isMorphEnabled) BOOL morphEnabled;
@property (nonatomic, strong) LNTouchConfig* touchContactConfig;
@property (nonatomic, strong) LNTouchConfig* touchRippleConfig;
@property (nonatomic) LNTouchVisualizerWindowTouchVisibility touchVisibility;

- (instancetype)initWithFrame:(CGRect)frame morphEnabled:(BOOL)morphEnabled touchVisibility:(LNTouchVisualizerWindowTouchVisibility)touchVisibility contactConfig:(nullable LNTouchConfig*)contactConfig rippleConfig:(nullable LNTouchConfig*)rippleConfig NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
