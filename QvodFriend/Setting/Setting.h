//
//  Setting.h
//  QShake
//
//  Created by douzifly on 13-10-24.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject

+ (void) increasePlayCount;
+ (NSInteger) playCount;
+ (BOOL) isRatingShowed;
+ (void) setRatingShowed:(BOOL) isShowed;
+ (BOOL) isMute;
+ (void) setMute:(BOOL) isMute;
+ (BOOL) isFirstPlayTipShowd;
+ (void) setFirstPlayTipShowd:(BOOL) isShowed;
@end
