//
//  LNOverlayVisualizerWindow.m
//  LNTouchVisualizer
//
//  Created by Joseph Blau on 11/30/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import "LNOverlayVisualizerWindow.h"

@implementation LNOverlayVisualizerWindow

// UIKit tries to get the rootViewController from the overlay window.
// Instead, try to find the rootViewController on some other
// application window.
// Fixes problems with status bar hiding, because it considers the
// overlay window a candidate for controlling the status bar.
- (UIViewController*)rootViewController
{
	for(UIWindow* window in self.windowScene.windows)
	{
		if(self == window)
		{
			continue;
		}
		
		if(window.isKeyWindow)
		{
			return window.rootViewController;
		}
	}
	
	return super.rootViewController;
}

@end
