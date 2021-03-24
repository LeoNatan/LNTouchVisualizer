//
//  LNTouchConfig.h
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LNTouchConfigTpye) {
    LNTouchConfigTpyeContact,
    LNTouchConfigTpyeRipple,
};

@interface LNTouchConfig : NSObject

@property (nonatomic) CGFloat alpha;
@property (nonatomic) NSTimeInterval fadeDuration;
@property (nonatomic, strong, nullable) UIColor *strokeColor;
@property (nonatomic, strong, nullable) UIColor *fillColor;

- (nonnull instancetype)initWithTouchConfigType:(LNTouchConfigTpye)configType NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init NS_UNAVAILABLE;

@end
