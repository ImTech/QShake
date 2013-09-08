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
    NSString *name = (style == ShakeSoundStyleBegin ? @"shake_begin" : @"shake_match");
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    [SoundUtil playSound:audioPath];
}

@end
