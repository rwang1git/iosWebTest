//
//  ViewController.h
//  webTestIOS
//
//  Created by TONY WANG on 14/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ASIHTTPRequest.h"
#import "JSONFileOperate.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,JSONFileOperateDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsTable;
- (IBAction)ss:(id)sender;
@end

