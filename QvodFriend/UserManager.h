//
//  UserManager.h
//  QShake
//
//  Created by douzifly on 13-10-21.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserManager : NSObject
+ (UserManager *) sharedInstance;
- (void) resetRandomMarker;
- (User*) random;
- (NSUInteger) count;
@end
