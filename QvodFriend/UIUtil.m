//
//  UIUtil.m
//  QvodFriend
//
//  Created by douzifly on 13-9-8.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "UIUtil.h"

@implementation UIUtil
+ (void) showAlert: (NSString* ) title
         withMessage: (NSString *) message
         leftButton: (NSString *) left
         rightButton: (NSString *) right
         delegate:(id) delegate
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:left otherButtonTitles:right, nil];
    [alert show];
}
@end
