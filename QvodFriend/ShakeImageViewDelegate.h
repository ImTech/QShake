//
//  ShakeImageViewDelegate.h
//  QvodFriend
//
//  Created by douzifly on 13-9-8.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShakeImageView;
@protocol ShakeImageViewDelegate <NSObject>

@optional
- (void) shakeImageViewShaked: (ShakeImageView*) imageView;

@end
