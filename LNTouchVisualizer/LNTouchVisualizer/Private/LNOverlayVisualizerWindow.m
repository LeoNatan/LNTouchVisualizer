//
//  LNOverlayVisualizerWindow.m
//  LNTouchVisualizer
//
//  Created by Léo Natan on 2017-12-02.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
//

#import "LNOverlayVisualizerWindow.h"

@import ObjectiveC;

@implementation LNOverlayVisualizerWindow

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

@end
