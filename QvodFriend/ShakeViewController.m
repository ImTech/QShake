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
#import "QVODHelper.h"

#define ANIM_SHAKE_COUNT 5
#define ANIM_SHAKE_KEY  @"ICON_SHAKE"

@interface ShakeViewController ()
{
    BOOL _isLodingData;
    UIImageView *_handleView;
    BOOL _isShowTable;
    CGPoint _movePoint;
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
//    [_dataTable setHandleBackgourndColor:[UIColor clearColor]];
    _dataTable.backgroundColor = [UIColor clearColor];
    
    [self.imgShake setImage:[UIImage imageNamed:@"a_05"]];
    self.imgShake.delegate = self;
//    [self shakeImage:_imgShake withRepeatCount:ANIM_SHAKE_COUNT];
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#E4E7EB"]];
    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"a_02"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
    @try {
        _navigationBar.barTintColor = [UIColor blackColor];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    
    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"a_11"] withFinishedUnselectedImage:[UIImage imageNamed:@"a_11"]];
    [self.tabBarItem setImage:[UIImage imageNamed:@"a_11"]];
   
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:@"#929292"], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    NSLog(@"tableView height:%@", self.dataTable.tableView);
    
    [self calcTableHeight];
    [self calcImagePos];
//    [self setNeedsStatusBarAppearanceUpdate];
    _searchBar.delegate = self;
    _searchBar.searchTextPositionAdjustment = UIOffsetMake(14.f, 0);
}

- (void) darg
{
    NSLog(@"drag");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search:%@", searchBar.text);
    [self beginSearchData:searchBar.text];
}


-(void) calcImagePos{
//    float tableHeight = self.dataTable.frame.size.height;
//    float tableWidth = self.dataTable.frame.size.width;
//    float tablex = self.dataTable.frame.origin.x;
//    float tabley = self.dataTable.frame.origin.y;
//    CGRect imgRect = self.imgShake.frame;
//    NSLog(@"tablex:%f, tabley:%f, tableH:%f, tableW:%f", tablex, tabley, tableHeight, tableWidth);
//    float x = tableWidth / 2 - imgRect.size.width / 2;
//    float y = tabley + tableHeight / 2 - imgRect.size.height;
//    NSLog(@"x:%f, y:%f", x, y);
//    CGRect rect = CGRectMake( x, y, imgRect.size
//                             .width, imgRect.size.height);
//    self.imgShake.frame = rect;
    BOOL ios7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    if (ios7) {
        _imgShake.center = self.view.center;
    } else {
        _imgShake.center = CGPointMake(self.view.center.x, self.view.center.y - 26);
    }
}

-(void) calcTableHeight {
    //    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL ios7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    CGRect naviFrame = self.navigationBar.frame;
    CGRect tabFrame = self.tabBarController.tabBar.frame;
    CGFloat height = 0;
    if (ios7) {
        height = tabFrame.origin.y - naviFrame.origin.y - naviFrame.size.height;
    } else {
        height = tabFrame.origin.y - naviFrame.origin.y - naviFrame.size.height - 22;
    }
//    NSLog(@"calcTableHeight height:%f", height);
    _dataTable.frame = CGRectMake(0, naviFrame.origin.y + naviFrame.size.height + 1, naviFrame.size.width, height - 16);
    // make hide
    _isShowTable = NO;
    CGRect rect = _dataTable.frame;
   _dataTable.frame = CGRectMake(rect.origin.x, rect.origin.y - rect.size.height + [_dataTable getHandleHeight], rect.size.width, rect.size.height);
}

- (void) hideTable
{
//    if(YES) return;
    _isShowTable = NO;
    [UIView animateWithDuration:0.8
                              delay:0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             _dataTable.transform = CGAffineTransformMakeTranslation(0, 0);
                         }
                        completion: ^(BOOL finished){
                            if(finished) {
                                _dataTable.handleDriction = HandleArrowDirectionDown;
                            }
                        }
     ];
    
}

- (void) showTable
{
//    if(YES) return;
    NSLog(@"showTable");
    _isShowTable = YES;
    CGFloat tableHeight = _dataTable.frame.size.height;
    NSLog(@"table height:%f", tableHeight);
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         _dataTable.transform = CGAffineTransformMakeTranslation(0, _dataTable.frame.size.height - [_dataTable getHandleHeight]);
                     }
                     completion:^(BOOL fininshed){
                         if(fininshed) {
                             _dataTable.handleDriction = HandleArrowDirectionUp;
                         }
                     }
     
     ];
}

- (void) toggleShowTable
{
    if (_isShowTable) {
        [self hideTable];
    } else {
        [self showTable];
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

- (void) beginSearchData:(NSString *) text
{
    [self shakeImage:_imgShake withRepeatCount:NSUIntegerMax];
    _isLodingData = YES;
    [self hideTable];
    NSString *path = [NSString stringWithFormat:@"search?kw=%@", [QVODHelper urlEncoded:text]];
    NSLog(@"path:%@", path);
    [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:path result:^(id JSON) {
        [NSThread sleepForTimeInterval:1];
        _isLodingData = NO;
        [_searchBar resignFirstResponder];
        [[_imgShake layer] removeAnimationForKey:ANIM_SHAKE_KEY];
        if(JSON == nil) {
            // failed
            return;
        }
        // play sucess music
        [self showTable];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *array = [parser objectWithString:JSON];
        for(NSMutableDictionary *dict in array) {
            NSLog(@"item:%@", [dict valueForKey:@"title"]);
        }
        self.dataTableController.datas = array;
        NSLog(@"reload Data");
        //        [self.dataTableController.tableView reloadData];
    }];
    
}


- (void) beginLoadData
{
    _isLodingData = YES;
    [self hideTable];
    [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:@"rand_ios" result:^(id JSON) {
        [NSThread sleepForTimeInterval:1];
        _isLodingData = NO;
        [[_imgShake layer] removeAnimationForKey:ANIM_SHAKE_KEY];
        if(JSON == nil) {
            // failed
            [SoundUtil playShakeSound:ShakeSoundStyleFailed];
            return;
        }
        // play sucess music
        [self showTable];
        [SoundUtil playShakeSound:ShakeSoundStyleEnd];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *array = [parser objectWithString:JSON];
        for(NSMutableDictionary *dict in array) {
            NSLog(@"item:%@", [dict valueForKey:@"title"]);
        }
        self.dataTableController.datas = array;
        NSLog(@"reload Data");
//        [self.dataTableController.tableView reloadData];
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

- (void)handleClicked
{
    [self toggleShowTable];
}

- (void) handleBeginMove {
    NSLog(@"move begin");
}

- (void) handleMoving:(CGPoint)point
{
    NSLog(@"moving y:%f", point.y);
    _movePoint = point;
    CGFloat y = _isShowTable ? point.y + _dataTable.tableView.frame.size.height : point.y;
    if (y > _dataTable.tableView.frame.size.height) {
        y = _dataTable.tableView.frame.size.height;
    }
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         _dataTable.transform = CGAffineTransformMakeTranslation(0, y);
                     }
                     completion: ^(BOOL finished){
                         if(finished) {
                             _dataTable.handleDriction = HandleArrowDirectionDown;
                         }
                     }
     ];
    
}

- (void) handleEndMove
{
    NSLog(@"move end");
    if (_movePoint.y > _dataTable.frame.size.height / 2) {
        [self showTable];
    } else {
        [self hideTable];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
