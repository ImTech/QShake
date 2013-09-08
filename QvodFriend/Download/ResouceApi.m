//
//  ResouceApi.m
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "ResouceApi.h"
#import "AFNetworking.h"

@implementation ResouceApi{
    
}

+(void)RequestJson:(NSString *) baseUrl
              Path:(NSString *) path
            result:(void (^)(id))result
{
    NSURL *url = [NSURL URLWithString:baseUrl];
    NSLog(@"begin request %@", url);
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(result) {
            result([[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result) {
            result(nil);
        }
    }];
}

+(void) RequestCb:(NSURLRequest *) request
              rsp:(NSHTTPURLResponse*) rsp
             data:(id) json
{
    
}

@end
