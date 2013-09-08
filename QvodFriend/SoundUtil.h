//
//  SoundUtil.h
//  QvodFriend
//
//  Created by douzifly on 13-9-8.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NSUInteger ShakeSoundStyle;
enum{
    ShakeSoundStyleBegin,
    ShakeSoundStyleEnd,
    ShakeSoundStyleFailed,
};

@interface SoundUtil : NSObject
{
}
+(void) playSound:(NSString*) path;
+ (void) playShakeSound:(ShakeSoundStyle) style;
@end
