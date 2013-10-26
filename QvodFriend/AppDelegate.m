//
//  AppDelegate.m
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "MobClick.h"

@implementation AppDelegate

- (void) layoutWindow:(UIApplication *) application
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        self.window.clipsToBounds =YES;
        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        
        //Added on 19th Sep 2013
        self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    }

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    [self layoutWindow:application];
    
    // Um start
    NSString *umKEY = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UmKey"];
    NSLog(@"UmKey%@", umKEY);
    [MobClick startWithAppkey:umKEY reportPolicy:REALTIME channelId:@"appstore"];
    [MobClick setLogEnabled:YES];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
 
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
    [self layoutWindow:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
