//
//  QVODHelper.m
//  QvodFriend
//
//  Created by douzifly on 13-9-7.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "QVODHelper.h"

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

+(BOOL)playWithHash:(NSString *) hash
{
    if(hash == nil) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:[@"qvodplayer:" stringByAppendingString:[QVODHelper urlEncoded:hash]]];
    NSLog(@"playWithHash url:%@", url);
    return [[UIApplication sharedApplication] openURL:url];
}

@end
