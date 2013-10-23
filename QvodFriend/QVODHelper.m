//
//  QVODHelper.m
//  QvodFriend
//
//  Created by douzifly on 13-9-7.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "QVODHelper.h"
#import "UIUtil.h"

@implementation QVODHelper

+(NSString *)urlEncoded:(NSString *)url
{
    // CFSTR("!*'();:@&amp;=+$,/?%#[] ")
    // CFSTR("!*'();:@&=+$,/?%#[] ")
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                (CFStringRef)url,
                                                                NULL,
                                                                CFSTR("!*'();:@&=+$,/?%#[] "),
                                                                kCFStringEncodingUTF8));
    return result;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clicked %d,", buttonIndex);
    if (buttonIndex == 0) {
        // install qvod
        [QVODHelper install];
    }
}

+ (BOOL)playWithHash:(NSString *) hash
{
    if(hash == nil) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:[@"qvodplayer:" stringByAppendingString:[QVODHelper urlEncoded:hash]]];
    NSLog(@"playWithHash url:%@", url);
    BOOL haveQvod = [[UIApplication sharedApplication] openURL:url];
    return haveQvod;
}

+ (BOOL)canPlay:(NSString *)hash
{
    if(hash == nil) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:[@"qvodplayer:" stringByAppendingString:[QVODHelper urlEncoded:hash]]];
    NSLog(@"playWithHash url:%@", url);
    return [[UIApplication sharedApplication] canOpenURL:url];
}


+ (void) install
{
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d", 504776703];
    BOOL ret = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    NSLog(@"redirect app store:%d", ret);
}

+ (void) rating
{
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
                     436957167 ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
