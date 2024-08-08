//
//  LNTouchVisualizerWindow.h
//  TouchVisualizer
//
//  Created by Léo Natan on 2021-03-24.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
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

- (void)visualizeEvent:(UIEvent*)event;

@end

NS_ASSUME_NONNULL_END
