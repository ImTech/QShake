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

+(BOOL)playWithHash:(NSString *) hash handleNoQvod:(BOOL) handle
{
    if(hash == nil) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:[@"qvodplayer:" stringByAppendingString:[QVODHelper urlEncoded:hash]]];
    NSLog(@"playWithHash url:%@", url);
    BOOL haveQvod = [[UIApplication sharedApplication] openURL:url];
    if (!haveQvod && handle) {
        //
        [UIUtil showAlert:@"安装组件" withMessage:@"还木有安装播放组件，现在安装？" leftButton:@"安装" rightButton:@"取消" delegate:^(UIAlertView  *alertView,NSInteger buttonIndex){
            NSLog(@"clicked %d,", buttonIndex);
            if (buttonIndex == 0) {
                // install qvod
                [QVODHelper install];
            }
        }];
    }
    return haveQvod;
}

+ (void) install
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.com/apps/QVODPLAYER"]];
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d", 350962117];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
    }
}




@end
