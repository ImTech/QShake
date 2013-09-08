//
//  FirstViewController.h
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeImageView.h"

@interface FirstViewController : UIViewController <ShakeImageViewDelegate>
- (IBAction)Click:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *dataTable;
@property (weak, nonatomic) IBOutlet ShakeImageView *imgShake;

@end
