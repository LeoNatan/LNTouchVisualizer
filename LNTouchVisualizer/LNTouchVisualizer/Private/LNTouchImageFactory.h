//
//  LNTouchImageFactory.h
//  LNTouchVisualizer
//
//  Created by Léo Natan on 2021-03-24.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNTouchConfig;

@interface LNTouchImageFactory : NSObject

+ (nonnull UIImage*)imageWithTouchConfig:(nonnull LNTouchConfig*)touchConfig;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
