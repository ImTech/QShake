//
//  IntruduceViewController.m
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "IntruduceViewController.h"
#import "IntruduceDataSource.h"

@interface IntruduceViewController ()

@end

@implementation IntruduceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initPages];
}

-(void) initPages
{
    NSLog(@"initPages");
    
    IntruduceDataSource *ds = [[IntruduceDataSource alloc] init];
    [self setViewControllers:[ds controllers] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.dataSource = ds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
