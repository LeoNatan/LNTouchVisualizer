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

@interface LNTouchVisualizerWindow : UIWindow

@property (nonatomic, getter=isTouchVisualizationEnabled) BOOL touchVisualizationEnabled;
@property (nonatomic, getter=isMorphEnabled) BOOL morphEnabled;

@property (nonatomic, strong) LNTouchConfig* touchContactConfig;
@property (nonatomic, strong) LNTouchConfig* touchRippleConfig;

- (instancetype)initWithFrame:(CGRect)frame touchVisualizationEnabled:(BOOL)touchVisualizationEnabled morphEnabled:(BOOL)morphEnabled contactConfig:(nullable LNTouchConfig*)contactConfig rippleConfig:(nullable LNTouchConfig*)rippleConfig NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
