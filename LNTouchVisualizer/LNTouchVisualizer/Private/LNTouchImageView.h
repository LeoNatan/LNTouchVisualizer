//
//  LNTouchSpotView.h
//  LNTouchVisualizer
//
//  Created by Léo Natan on 2017-12-02.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNTouchConfig;

@protocol LNTouchFadingView <NSObject>

@property (nonatomic) NSTimeInterval timestamp;
@property (nonatomic, getter=isFadingOut) BOOL fadingOut;
@property (nonatomic) BOOL shouldAutomaticallyRemoveAfterTimeout;

@end

@interface LNTouchImageView : UIImageView <LNTouchFadingView>

@end
