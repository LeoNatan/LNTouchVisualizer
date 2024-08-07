//
//  UIWindowScene+TouchVisualizer.h
//  LNTouchVisualizer
//
//  Created by Léo Natan on 2021-03-24.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LNTouchVisualizer/LNTouchVisualizer.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindowScene (TouchVisualizer)

@property (nonatomic) BOOL touchVisualizerEnabled;
@property (nonatomic, strong, readonly) LNTouchVisualizerWindow* touchVisualizerWindow;

@end

NS_ASSUME_NONNULL_END
