//
//  FirstViewController.h
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeImageView.h"
#import "HandleTableView.h"

@interface ShakeViewController : UIViewController <ShakeImageViewDelegate, HandleTableViewDelgate>
- (IBAction)Click:(id)sender;
@property (weak, nonatomic) IBOutlet HandleTableView *dataTable;
@property (weak, nonatomic) IBOutlet ShakeImageView *imgShake;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
