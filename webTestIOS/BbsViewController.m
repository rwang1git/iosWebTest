                       //
//  BbsViewController.m
//  webTestIOS
//
//  Created by 王如栋 on 2017/12/31.
//  Copyright © 2017年 tonywang. All rights reserved.
//

#import "BbsViewController.h"

@implementation BbsViewController
- (void)viewDidLoad {
    NSURL *url = [NSURL URLWithString:self.bbsUrl];
    NSLog(@"this URL is %@",self.bbsUrl);
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.bbsWebView loadRequest:request];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnClick:(id)sender {
    if(self.savedVc)
    {
        [self.savedVc dismissViewControllerAnimated:YES completion:nil];
        //[self.savedVc presentViewController:self.savedVc animated:YES completion: nil];
    }
}
@end
