//
//  BbsViewController.h
//  webTestIOS
//
//  Created by 王如栋 on 2017/12/31.
//  Copyright © 2017年 tonywang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <WebKit/WebKit.h>

@interface BbsViewController : UIViewController
@property (nonatomic) NSMutableString *bbsUrl;
@property UIViewController *savedVc;
@property (weak, nonatomic) IBOutlet UIWebView *bbsWebView;
- (IBAction)returnClick:(id)sender;

@end
