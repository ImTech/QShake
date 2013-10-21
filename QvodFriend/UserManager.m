//
//  UserManager.m
//  QShake
//
//  Created by douzifly on 13-10-21.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "UserManager.h"
#define numberCount 40
@implementation UserManager
{
    int numbers[numberCount];
    int numberIndex;
    NSMutableDictionary *video_data;
    NSMutableArray *users;
}

+ (UserManager *)sharedInstance
{
    static UserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserManager alloc] init];
        [instance loadData];
    });
    return instance;
}

- (void) loadData
{
    NSString *pathlist = [[NSBundle mainBundle] pathForResource:@"video_data" ofType:@"plist"];
    video_data = [[NSMutableDictionary alloc] initWithContentsOfFile:pathlist];
    users = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < numberCount; i++) {
        User *u = [[User alloc] init];
        u.name = [[video_data objectForKey:@"froms"] objectForKey:[NSString stringWithFormat:@"%d", i]];
        u.avataPath = [NSString stringWithFormat:@"head_%d", i];
        [users addObject:u];
    }
    
}

- (User *)random
{
    int max = numberCount;
    int min = 1;
    int randNum = rand() % (max - min) + min;
//    NSLog(@"----randNum:%d", randNum);
//    if ([self checkExists:randNum]) {
//        return [self random];
//    }
//    [self addNumber:randNum];
    return [users objectAtIndex:randNum];
}

- (void)resetRandomMarker
{
    for (int i = 0; i < numberCount; i++) {
        numbers[i] = 0;
    }
    numberIndex = 0;
}

- (void) addNumber:(int) number
{
    numbers[numberIndex++] = number;
}

- (BOOL) checkExists:(int) number
{
    for (int i = 0; i < numberCount; i++) {
        if(numbers[i] == number) {
            return YES;
        }
    }
    return NO;
}

- (NSUInteger)count
{
    return numberCount;
}

@end
