//
//  UIUtil.h
//  QvodFriend
//
//  Created by douzifly on 13-9-8.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtil : NSObject
+ (UIAlertView*) showAlert: (NSString* ) title
       withMessage: (NSString *) message
        leftButton: (NSString *) left
       rightButton: (NSString *) right
          delegate: (id) delegate;
@end
