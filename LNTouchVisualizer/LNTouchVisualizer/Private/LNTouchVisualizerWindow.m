//
//  LNTouchVisualizerWindow.m
//  TouchVisualizer
//
//  Created by Joe Blau on 3/22/14.
//  Copyright (c) 2014 conopsys. All rights reserved.
//

#import <LNTouchVisualizer/LNTouchVisualizerWindow.h>
#import "LNOverlayVisualizerWindow.h"
#import "LNTouchImageView.h"
#import <LNTouchVisualizer/LNTouchConfig.h>
#import "LNTouchImageFactory.h"

static const NSTimeInterval TOUCH_VISUALIZER_WINDOW_REMOVE_DELAY = 0.2;
static const NSTimeInterval TOUCH_VISUALIZER_PULSING_TIMER_DELAY = 0.6;
static const NSTimeInterval TOUCH_VISUALIZER_MORPH_DURATION = 0.4;
static const NSTimeInterval TOUCH_VISUALIZER_ZERO_DELAY = 0.0;


@interface LNTouchVisualizerWindow ()

@property (nonatomic, strong) UIWindow* overlayWindow;
@property (nonatomic) BOOL fingerTipRemovalScheduled;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) NSSet* allTouches;

@property (nonatomic, strong) UIImage* touchImage;
@property (nonatomic, strong) UIImage* rippleImage;

@end

@implementation LNTouchVisualizerWindow

- (instancetype)initWithFrame:(CGRect)frame
{
	return [self initWithFrame:frame touchVisualizationEnabled:YES morphEnabled:YES contactConfig:nil rippleConfig:nil];
}

- (instancetype)initWithFrame:(CGRect)frame touchVisualizationEnabled:(BOOL)touchVisualizationEnabled morphEnabled:(BOOL)morphEnabled contactConfig:(nullable LNTouchConfig*)contactConfig rippleConfig:(nullable LNTouchConfig*)rippleConfig
{
	self = [super initWithFrame:frame];
	if(self)
	{
		_morphEnabled = morphEnabled;
		_touchVisualizationEnabled = touchVisualizationEnabled;
		_touchContactConfig = contactConfig ?: [LNTouchConfig touchConfig];
		_touchRippleConfig = rippleConfig ?: [LNTouchConfig rippleConfig];
	}
	return self;
}

- (void)setTouchContactConfig:(LNTouchConfig *)touchContactConfig
{
	_touchContactConfig = touchContactConfig;
	_touchImage = nil;
}

- (void)setTouchRippleConfig:(LNTouchConfig *)touchRippleConfig
{
	_touchRippleConfig = touchRippleConfig;
	_rippleImage = nil;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
	[super traitCollectionDidChange:previousTraitCollection];
	
	if(self.traitCollection.userInterfaceStyle == previousTraitCollection.userInterfaceStyle)
	{
		return;
	}
	
	_touchImage = nil;
	_rippleImage = nil;
}

#pragma mark - Touch / Ripple and Images

- (UIImage *)touchImage
{
	if(_touchImage == nil)
	{
		_touchImage = [LNTouchImageFactory imageWithTouchConfig:self.touchContactConfig];
	}
	
	return _touchImage;
}

- (UIImage *)rippleImage
{
	if(_rippleImage == nil)
	{
		_rippleImage = [LNTouchImageFactory imageWithTouchConfig:self.touchRippleConfig];
	}
	
	return _rippleImage;
}

#pragma mark - Active

- (BOOL)anyScreenIsMirrored
{
	if([UIScreen instancesRespondToSelector:@selector(mirroredScreen)] == NO)
	{
		return NO;
	}
	
	for(UIScreen *screen in UIScreen.screens)
	{
		if(screen.mirroredScreen != nil)
		{
			return YES;
		}
	}
	return NO;
}

#pragma mark - UIWindow overrides

- (void)sendEvent:(UIEvent *)event
{
	[super sendEvent:event];
	
	if(self.touchVisualizationEnabled == NO)
	{
		return;
		
	}
	
	self.allTouches = event.allTouches;
	
	for(UITouch *touch in self.allTouches.allObjects)
	{
		switch(touch.phase)
		{
			case UITouchPhaseRegionEntered:
			case UITouchPhaseRegionMoved:
			case UITouchPhaseRegionExited:
				continue;
			case UITouchPhaseBegan:
			case UITouchPhaseMoved:
			{
				// Generate ripples
				LNTouchImageView *rippleView = [[LNTouchImageView alloc] initWithImage:self.rippleImage];
				[self.overlayWindow addSubview:rippleView];
				
				rippleView.alpha = self.touchRippleConfig.alpha;
				rippleView.center = [touch locationInView:self.overlayWindow];
				
				[UIView animateWithDuration:self.touchRippleConfig.fadeDuration delay:TOUCH_VISUALIZER_ZERO_DELAY options:UIViewAnimationOptionCurveEaseIn animations:^{
					[rippleView setAlpha:0.0];
					[rippleView setFrame:CGRectInset(rippleView.frame, 24, 24)];
				} completion:^(BOOL finished) {
					[rippleView removeFromSuperview];
				}];
			}
			case UITouchPhaseStationary:
			{
				LNTouchImageView *touchView = (LNTouchImageView *)[self.overlayWindow viewWithTag:touch.hash];
				
				if(touch.phase != UITouchPhaseStationary && touchView != nil && touchView.isFadingOut)
				{
					[self.timer invalidate];
					[touchView removeFromSuperview];
					touchView = nil;
				}
				
				if(touchView == nil && touch.phase != UITouchPhaseStationary)
				{
					touchView = [[LNTouchImageView alloc] initWithImage:self.touchImage];
					[self.overlayWindow addSubview:touchView];
					
					if(self.morphEnabled)
					{
						if(self.timer)
						{
							[self.timer invalidate];
						}
						
						self.timer = [NSTimer scheduledTimerWithTimeInterval:TOUCH_VISUALIZER_PULSING_TIMER_DELAY target:self selector:@selector(performMorphWithTouchView:) userInfo:touchView repeats:YES];
					}
				}
				if(!touchView.isFadingOut)
				{
					touchView.alpha = self.touchContactConfig.alpha;
					touchView.center = [touch locationInView:self.overlayWindow];
					touchView.tag = touch.hash;
					touchView.timestamp = touch.timestamp;
					touchView.shouldAutomaticallyRemoveAfterTimeout = [self shouldAutomaticallyRemoveFingerTipForTouch:touch];
				}
				break;
			}
			case UITouchPhaseEnded:
			case UITouchPhaseCancelled:
			{
				[self _removeFingerTipWithHash:touch.hash animated:YES];
				break;
			}
		}
	}
	
	[self _scheduleFingerTipRemoval];    // We may not see all UITouchPhaseEnded/UITouchPhaseCancelled events.
}


- (UIWindow*)overlayWindow
{
	if(_overlayWindow == nil)
	{
		_overlayWindow = [[LNOverlayVisualizerWindow alloc] initWithFrame:self.frame];
		_overlayWindow.userInteractionEnabled = NO;
		_overlayWindow.windowLevel = UIWindowLevelStatusBar;
		_overlayWindow.backgroundColor = UIColor.clearColor;
		_overlayWindow.hidden = NO;
		_overlayWindow.windowScene = self.windowScene;
	}
	
	return _overlayWindow;
}
#pragma mark - Private

- (void)_scheduleFingerTipRemoval
{
	if(self.fingerTipRemovalScheduled == YES)
	{
		return;
	}
	
	self.fingerTipRemovalScheduled = YES;
	[self performSelector:@selector(removeInactiveFingerTips) withObject:nil afterDelay:0.1];
}

- (void)removeInactiveFingerTips
{
	self.fingerTipRemovalScheduled = NO;
	
	NSTimeInterval now = NSProcessInfo.processInfo.systemUptime;
	
	for(LNTouchImageView *touchView in self.overlayWindow.subviews)
	{
		if([touchView isKindOfClass:LNTouchImageView.class] == NO)
		{
			continue;
		}
		
		if(touchView.shouldAutomaticallyRemoveAfterTimeout && now > touchView.timestamp + TOUCH_VISUALIZER_WINDOW_REMOVE_DELAY)
		{
			[self _removeFingerTipWithHash:touchView.tag animated:YES];
		}
	}
	
	if(self.overlayWindow.subviews.count > 0)
	{
		[self _scheduleFingerTipRemoval];
	}
}

- (void)_removeFingerTipWithHash:(NSUInteger)hash animated:(BOOL)animated
{
	LNTouchImageView *touchView = (LNTouchImageView *)[self.overlayWindow viewWithTag:hash];
	if(touchView == nil || touchView.isFadingOut)
	{
		return;
	}
	
	BOOL animationsWereEnabled = [UIView areAnimationsEnabled];
	
	dispatch_block_t animations = ^ {
		touchView.frame = CGRectMake(touchView.center.x - touchView.frame.size.width,
									 touchView.center.y - touchView.frame.size.height,
									 touchView.frame.size.width * 2, touchView.frame.size.height * 2);
		
		touchView.alpha = 0.0;
	};
	
	if(animated)
	{
		[UIView setAnimationsEnabled:YES];
		[UIView animateWithDuration:self.touchContactConfig.fadeDuration animations:animations];
		[UIView setAnimationsEnabled:animationsWereEnabled];
	}
	else
	{
		animations();
	}
	
	touchView.fadingOut = YES;
	[touchView performSelector:@selector(removeFromSuperview)
					withObject:nil
					afterDelay:self.touchContactConfig.fadeDuration];
}

- (BOOL)shouldAutomaticallyRemoveFingerTipForTouch:(UITouch *)touch;
{
	// We don't reliably get UITouchPhaseEnded or UITouchPhaseCancelled
	// events via -sendEvent: for certain touch events. Known cases
	// include swipe-to-delete on a table view row, and tap-to-cancel
	// swipe to delete. We automatically remove their associated
	// fingertips after a suitable timeout.
	//
	// It would be much nicer if we could remove all touch events after
	// a suitable time out, but then we'll prematurely remove touch and
	// hold events that are picked up by gesture recognizers (since we
	// don't use UITouchPhaseStationary touches for those. *sigh*). So we
	// end up with this more complicated setup.
	
	UIView *touchView = [touch view];
	touchView = [touchView hitTest:[touch locationInView:touchView] withEvent:nil];
	
	while(touchView != nil)
	{
		if([touchView isKindOfClass:UITableViewCell.class])
		{
			for(UIGestureRecognizer *recognizer in touch.gestureRecognizers)
			{
				if([recognizer isKindOfClass:UISwipeGestureRecognizer.class])
					return YES;
			}
		}
		
		if([touchView isKindOfClass:UITableView.class] &&
		   touch.gestureRecognizers.count == 0)
		{
			return YES;
		}
		touchView = touchView.superview;
	}
	
	return NO;
}

- (void)performMorphWithTouchView:(NSTimer *)timer
{
	UIView *touchView = timer.userInfo;
	
	// Start
	touchView.alpha = self.touchContactConfig.alpha;
	touchView.transform = CGAffineTransformMakeScale(1, 1);
	[UIView animateWithDuration:TOUCH_VISUALIZER_MORPH_DURATION / 4
						  delay:TOUCH_VISUALIZER_ZERO_DELAY
						options:0
					 animations:^{
		// End
		touchView.transform = CGAffineTransformMakeScale(1, 1.2);
	}
					 completion:^(BOOL finished) {
		[UIView animateWithDuration:TOUCH_VISUALIZER_MORPH_DURATION / 4
							  delay:TOUCH_VISUALIZER_ZERO_DELAY
							options:0
						 animations:^{
			// End
			touchView.transform = CGAffineTransformMakeScale(1.2, 0.9);
		}
						 completion:^(BOOL finished) {
			[UIView animateWithDuration:TOUCH_VISUALIZER_MORPH_DURATION / 4
								  delay:TOUCH_VISUALIZER_ZERO_DELAY
								options:0
							 animations:^{
				// End
				touchView.transform = CGAffineTransformMakeScale(0.9, 0.9);
			}
							 completion:^(BOOL finished) {
				[UIView animateWithDuration:TOUCH_VISUALIZER_MORPH_DURATION / 4
									  delay:TOUCH_VISUALIZER_ZERO_DELAY
									options:0
								 animations:^{
					// End
					touchView.transform = CGAffineTransformMakeScale(1, 1);
				}
								 completion:^(BOOL finished){
					// If there are no touches, remove this morping touch
					if(self.allTouches.count == 0)
					{
						[touchView removeFromSuperview];
					}
				}];
			}];
		}];
	}];
}

@end
