//
//  SoundUtil.m
//  QvodFriend
//
//  Created by douzifly on 13-9-8.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "SoundUtil.h"
#import <AVFoundation/AVFoundation.h>

static AVAudioPlayer* _player;

@implementation SoundUtil

+(void)playSound:(NSString *) path
{
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    NSError *err;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&err];
    if(err != nil) {
        NSLog(@"err:%@", err);
    }
     [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    _player.volume = 1.0;
    BOOL ret = NO;
    ret = [_player prepareToPlay];
    NSLog(@"prepare play:%d", ret);
    ret = [_player play];
    NSLog(@"play sound:%d path:%@", ret, soundUrl);
}

+ (void) playShakeSound:(ShakeSoundStyle) style
{
    NSString *name = nil;
    NSString *ext = @"mp3";
    if (style == ShakeSoundStyleBegin) {
        name = @"shake_begin";
    } else if (style == ShakeSoundStyleEnd) {
        name = @"shake_match";
    } else if (style == ShakeSoundStyleFailed) {
        name = @"failed";
        ext = @"wav";
    }
    if (name == nil) {
        return;
    }
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    [SoundUtil playSound:audioPath];
}

@end
