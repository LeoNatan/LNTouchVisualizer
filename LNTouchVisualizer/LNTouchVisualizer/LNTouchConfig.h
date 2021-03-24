//
//  LNTouchConfig.h
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
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
