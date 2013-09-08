//
//  ResouceApi.h
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResouceApi : NSObject
+(void)RequestJson:(NSString *) baseUrl
              Path:(NSString *) path
            result:(void (^)(id))result;
@end
