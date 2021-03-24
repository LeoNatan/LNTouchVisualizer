//
//  UIWindowScene+TouchVisualizer.m
//  LNTouchVisualizer
//
//  Created by Leo Natan on 3/24/21.
//

#import "UIWindowScene+TouchVisualizer.h"
#import <LNTouchVisualizer/LNTouchVisualizerWindow.h>

@import ObjectiveC;

static const void* LNTouchVisualizerWindowKey = &LNTouchVisualizerWindowKey;

@interface _LNSceneTouchVisualizerWindow : LNTouchVisualizerWindow @end
@implementation _LNSceneTouchVisualizerWindow

- (UIWindow *)overlayWindow
{
	return self;
}

- (BOOL)_canBecomeKeyWindow
{
	return NO;
}

@end

@interface UIWindow (TouchVisualizerForwarding) @end
@implementation UIWindow (TouchVisualizerForwarding)

+ (void)load
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		Method m1 = class_getInstanceMethod(self, @selector(sendEvent:));
		Method m2 = class_getInstanceMethod(self, @selector(__ln_vis_sendEvent:));
		method_exchangeImplementations(m1, m2);
	});
}

- (void)__ln_vis_sendEvent:(UIEvent *)event
{
	if([self isKindOfClass:[_LNSceneTouchVisualizerWindow class]])
	{
		return;
	}
	
	if(self.windowScene.touchVisualizerEnabled)
	{
		[self.windowScene.touchVisualizerWindow sendEvent:event];
	}
	[self __ln_vis_sendEvent:event];
}

@end

@implementation UIWindowScene (TouchVisualizer)

- (LNTouchVisualizerWindow*)touchVisualizerWindow
{
	LNTouchVisualizerWindow* rv = objc_getAssociatedObject(self, LNTouchVisualizerWindowKey);
	
	if(rv == nil)
	{
		rv = [_LNSceneTouchVisualizerWindow new];
		rv.windowLevel = 100000000000;
		rv.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.0];
		rv.hidden = YES;
		rv.userInteractionEnabled = NO;
		rv.frame = UIScreen.mainScreen.bounds;
		rv.windowScene = self;
		
		objc_setAssociatedObject(self, LNTouchVisualizerWindowKey, rv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	return rv;
}

- (void)setTouchVisualizerEnabled:(BOOL)touchVisualizerEnabled
{
	self.touchVisualizerWindow.hidden = touchVisualizerEnabled == NO;
}

- (BOOL)touchVisualizerEnabled
{
	return self.touchVisualizerWindow.hidden == NO;
}

@end
