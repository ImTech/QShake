//
//  FirstViewController.m
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "ShakeViewController.h"
#import "Download/ResouceApi.h"
#import "SBJson.h"
#import "DataTableContrller.h"
#import "SoundUtil.h"
#import "UIColor+Hex.h"

#define ANIM_SHAKE_COUNT 5
#define ANIM_SHAKE_KEY  @"ICON_SHAKE"

@interface ShakeViewController ()
{
    BOOL _isLodingData;
    UIImageView *_handleView;
    BOOL _isShowTable;
    CGFloat _tableShowY;
    CGFloat _tableHideY;
}
@property(strong, nonatomic) DataTableContrller *dataTableController;
@end
@implementation ShakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.dataTableController = [[DataTableContrller alloc] init];
    self.dataTableController.tableView = self.dataTable.tableView;
    self.dataTable.delegate = self;
    _dataTable.tableView.backgroundColor = [UIColor whiteColor];
    [_dataTable setHandleBackgourndColor:[UIColor colorWithHex:@"#E4E7EB"]];
    
    [self.imgShake setImage:[UIImage imageNamed:@"a_05"]];
    self.imgShake.delegate = self;
    [self shakeImage:_imgShake withRepeatCount:ANIM_SHAKE_COUNT];
//    [self.imgShake setBackgroundColor:[UIColor colorWithHex:@"#E4E7EB"]];
//    self.view.backgroundColor = [UIColor colorWithHex:@"#19759c"];
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#E4E7EB"]];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"a_02"] forBarMetrics:UIBarMetricsDefault];
    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"a_11"] withFinishedUnselectedImage:[UIImage imageNamed:@"a_11"]];
    [self.tabBarItem setImage:[UIImage imageNamed:@"a_11"]];
   
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:@"#929292"], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    NSLog(@"tableView height:%@", self.dataTable.tableView);
    
    [self calcTableHeight];
    [self calcImagePos];
    [self hideTable:NO];
}

-(void) calcImagePos{
//    float height = [[UIScreen mainScreen] bounds].size.height;
//    float width = [[UIScreen mainScreen] bounds].size.width;
//    NSLog(@"calcImagePos y:%f", height / 2);
//    self.imgShake.center = CGPointMake(width / 2, height);
    float tableHeight = self.dataTable.frame.size.height;
    float tableWidth = self.dataTable.frame.size.width;
    float tablex = self.dataTable.frame.origin.x;
    float tabley = self.dataTable.frame.origin.y;
    CGRect imgRect = self.imgShake.frame;
    NSLog(@"tablex:%f, tabley:%f, tableH:%f, tableW:%f", tablex, tabley, tableHeight, tableWidth);
    float x = tableWidth / 2 - imgRect.size.width / 2;
    float y = tabley + tableHeight / 2 - imgRect.size.height;
    NSLog(@"x:%f, y:%f", x, y);
    CGRect rect = CGRectMake( x, y, imgRect.size
                             .width, imgRect.size.height);
    self.imgShake.frame = rect;
}

-(void) calcTableHeight {
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL ios7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    float tableHeight = 0;
    if(ios7) {
        // ios 7 计算要加上statusbar和tabbar
        tableHeight = screenHeight - 20 - 44 - 49;
    } else {
        tableHeight = self.view.frame.size.height - 44;
    }
    NSLog(@"tableHeight:%f screenHeight:%f ios7:%d", tableHeight, screenHeight, ios7);
    CGRect rect = self.dataTable.frame;
//    self.dataTable.backgroundColor = [UIColor redColor];
    NSLog(@"yyyy:%f", self.dataTable.frame.origin.y);
    self.dataTable.frame = CGRectMake(0, self.dataTable.frame.origin.y, rect.size.width, tableHeight);
    [self.dataTable layoutIfNeeded];
    _tableShowY = _dataTable.frame.origin.y;
    
}

- (void) hideTable:(BOOL) anim
{
    _isShowTable = NO;
    if(_tableHideY == 0) {
        CGFloat handleHeight = self.dataTable.handleHeight;
        _tableHideY = _dataTable.frame.origin.y -_dataTable.frame.size.height + handleHeight;
    }
   CGRect rect = _dataTable.frame;
    _dataTable.frame = CGRectMake(rect.origin.x, _tableHideY, rect.size.width, rect.size.height);
}

- (void) showTable:(BOOL) anim
{
    _isShowTable = YES;
    CGRect rect = _dataTable.frame;
    _dataTable.frame = CGRectMake(rect.origin.x, _tableShowY, rect.size.width, rect.size.height);
}

- (void) toggleShowTable:(BOOL) anim
{
    if (_isShowTable) {
        [self hideTable:anim];
    } else {
        [self showTable:anim];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.imgShake becomeFirstResponder];
    [super viewWillAppear:animated];
}

-(void) shakeImageViewShaked:(ShakeImageView *)imageView
{
    if(_isLodingData) {
        NSLog(@"loading");
        return;
    }
    [self shakeImage:imageView withRepeatCount:NSUIntegerMax];
    [SoundUtil playShakeSound:ShakeSoundStyleBegin];
    [self beginLoadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.imgShake resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void) shakeImage:(UIImageView *) img withRepeatCount:(NSUInteger) count
{
    NSLog(@"shake anim count:%d", count);
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setToValue:[NSNumber numberWithFloat:0.0f]];
    [anim setFromValue:[NSNumber numberWithFloat:M_PI/ 16]];
    [anim setDuration:0.1];
    [anim setRepeatCount:count];
    [anim setAutoreverses:YES];
    [[img layer] addAnimation:anim forKey:ANIM_SHAKE_KEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) beginLoadData
{
    _isLodingData = YES;
    [self hideTable:YES];
    [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:@"rand_ios" result:^(id JSON) {
        _isLodingData = NO;
        [[_imgShake layer] removeAnimationForKey:ANIM_SHAKE_KEY];
        if(JSON == nil) {
            // failed
            [SoundUtil playShakeSound:ShakeSoundStyleFailed];
            return;
        }
        // play sucess music
        [self showTable:YES];
        [SoundUtil playShakeSound:ShakeSoundStyleEnd];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *array = [parser objectWithString:JSON];
        for(NSMutableDictionary *dict in array) {
            NSLog(@"item:%@", [dict valueForKey:@"title"]);
        }
        self.dataTableController.datas = array;
        NSLog(@"reload Data");
        [self.dataTableController.tableView reloadData];
    }];
 
}

- (IBAction)Click:(id)sender {
     [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:@"rand_land" result:^(id JSON) {
         SBJsonParser *parser = [[SBJsonParser alloc] init];
         NSMutableArray *array = [parser objectWithString:JSON];
         for(NSMutableDictionary *dict in array) {
             NSLog(@"item:%@", [dict valueForKey:@"title"]);
         }
         self.dataTableController.datas = array;
         NSLog(@"reload Data");
         [self.dataTableController.tableView reloadData];
     }];
}

-(BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)handleClicked
{
    [self toggleShowTable:YES];
}

@end
