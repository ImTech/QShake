//
//  QVODHelper.h
//  QvodFriend
//
//  Created by douzifly on 13-9-7.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QVODHelper : NSObject
+ (BOOL) playWithHash:(NSString*) hash;
+ (NSString *)urlEncoded:(NSString*)url;
@end
