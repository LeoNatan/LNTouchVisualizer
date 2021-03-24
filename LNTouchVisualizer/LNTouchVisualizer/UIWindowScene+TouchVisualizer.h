//
//  UIWindowScene+TouchVisualizer.h
//  LNTouchVisualizer
//
//  Created by Leo Natan on 3/24/21.
//

#import <UIKit/UIKit.h>
#import <LNTouchVisualizer/LNTouchVisualizer.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindowScene (TouchVisualizer)

@property (nonatomic) BOOL touchVisualizerEnabled;
@property (nonatomic, strong, readonly) LNTouchVisualizerWindow* touchVisualizerWindow;

@end

NS_ASSUME_NONNULL_END
