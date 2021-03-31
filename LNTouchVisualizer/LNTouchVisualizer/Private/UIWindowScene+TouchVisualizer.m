//
//  UIWindowScene+TouchVisualizer.m
//  LNTouchVisualizer
//
//  Created by Leo Natan on 3/24/21.
//

#import <LNTouchVisualizer/UIWindowScene+TouchVisualizer.h>
#import <LNTouchVisualizer/LNTouchVisualizerWindow.h>

@import ObjectiveC;

static const void* LNTouchVisualizerWindowKey = &LNTouchVisualizerWindowKey;

@interface _LNSceneTouchVisualizerWindow : LNTouchVisualizerWindow @end
@implementation _LNSceneTouchVisualizerWindow

#ifndef LNPopupControllerEnforceStrictClean
+ (void)load
{
	@autoreleasepool {
		NSMutableString* name = [@"_" mutableCopy];
		[name appendString:@"canAffect"];
		[name appendString:[NSStringFromClass(UIStatusBarManager.class) substringWithRange:NSMakeRange(2, 9)]];
		[name appendString:[NSStringFromClass(UIBarAppearance.class) substringFromIndex:5]];
		
		Method m = class_getInstanceMethod(self, @selector(_cASBA));
		class_addMethod(self, NSSelectorFromString(name), method_getImplementation(m), method_getTypeEncoding(m));
		
		name = [@"_" mutableCopy];
		[name appendString:[NSStringFromSelector(@selector(canBecomeFirstResponder)) substringToIndex:9]];
		[name appendString:[NSStringFromSelector(@selector(isKeyWindow)) substringFromIndex:2]];
		
		m = class_getInstanceMethod(self, @selector(_cASBA));
		class_addMethod(self, NSSelectorFromString(name), method_getImplementation(m), method_getTypeEncoding(m));
	}
}

//_canAffectStatusBarAppearance
- (BOOL)_cASBA
{
	return NO;
}

//_canBecomeKeyWindow
- (BOOL)_cBKW
{
	return NO;
}
#endif

- (UIWindow *)overlayWindow
{
	return self;
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
