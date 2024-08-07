//
//  LNTouchConfig.h
//  LNTouchVisualizer
//
//  Created by Léo Natan on 2021-03-24.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNTouchConfig : NSObject

@property (nonatomic) CGFloat alpha;
@property (nonatomic) NSTimeInterval fadeDuration;
@property (nonatomic, strong, nullable) UIColor *strokeColor;
@property (nonatomic, strong, nullable) UIColor *fillColor;

@property (nonatomic, class, strong, readonly) LNTouchConfig* rippleConfig;
@property (nonatomic, class, strong, readonly) LNTouchConfig* touchConfig;

@end

NS_ASSUME_NONNULL_END
