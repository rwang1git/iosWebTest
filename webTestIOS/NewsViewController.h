//
//  NewsViewController.h
//  webTestIOS
//
//  Created by TONY WANG on 19/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//  
//  This is show detail news page.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myNewsView;
@property (weak, nonatomic) NSString *newsUrl;
@end
