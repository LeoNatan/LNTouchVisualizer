//
//  LNTouchImageFactory.h
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNTouchConfig;

@interface LNTouchImageFactory : NSObject

+ (nonnull UIImage*)imageWithTouchConfig:(nonnull LNTouchConfig*)touchConfig;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
