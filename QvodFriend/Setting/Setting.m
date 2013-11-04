//
//  Setting.m
//  QShake
//
//  Created by douzifly on 13-10-24.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "Setting.h"

#define KEY_PLAY_COUNT @"play_count"
#define KEY_IS_RATING_SHOWED @"is_rating_showd"
#define KEY_IS_MUTE @"is_mute"
#define KEY_IS_FIRST_PLAY_SHOWD @"is_first_play_showd"
#define KEY_SHOW_INTRUDUCE @"is_show_intruduce"

@implementation Setting
+ (void)increasePlayCount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger current = [userDefaults integerForKey:KEY_PLAY_COUNT];
    [userDefaults setInteger:current + 1 forKey:KEY_PLAY_COUNT];
}

+ (NSInteger)playCount
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:KEY_PLAY_COUNT];
}

+ (BOOL)isRatingShowed
{
    return [[NSUserDefaults standardUserDefaults] boolForKey: KEY_IS_RATING_SHOWED];
}

+ (void)setRatingShowed:(BOOL)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:KEY_IS_RATING_SHOWED];
}

+ (BOOL) isMute
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IS_MUTE];
}

+ (void)setMute:(BOOL)isMute
{
    [[NSUserDefaults standardUserDefaults] setBool:isMute forKey:KEY_IS_MUTE];
}

+ (BOOL) isFirstPlayTipShowd
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IS_FIRST_PLAY_SHOWD];
}

+ (void)setFirstPlayTipShowd:(BOOL)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:KEY_IS_FIRST_PLAY_SHOWD];
}

+ (BOOL)showIntruduce
{
    if (![[NSUserDefaults standardUserDefaults] objectIsForcedForKey:KEY_SHOW_INTRUDUCE]) {
        return YES;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SHOW_INTRUDUCE];
}

+ (void)setShowIntruduce:(BOOL)show
{
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:KEY_SHOW_INTRUDUCE];
}
        
@end
