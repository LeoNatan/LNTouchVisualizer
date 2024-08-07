//
//  LNTouchSpotView.h
//  LNTouchVisualizer
//
//  Created by Léo Natan on 2017-12-02.
//  Copyright © 2014-2024 Léo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNTouchImageView : UIImageView

@property (nonatomic) NSTimeInterval timestamp;
@property (nonatomic) BOOL shouldAutomaticallyRemoveAfterTimeout;
@property (nonatomic, getter=isFadingOut) BOOL fadingOut;

@end
