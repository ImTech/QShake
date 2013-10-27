//
//  BrowserViewController.h
//  QShake
//
//  Created by douzifly on 13-9-21.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBroswerBar.h"

@interface BrowserViewController : UIViewController <UITextFieldDelegate, QBroswerBarDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet QBroswerBar *toolBar;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;


@end
