//
//  ItemDetailAViewController.h
//  webTestIOS
//
//  Created by TONY WANG on 24/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//


#import <UIKit/UIKit.h>
#include "ASIHTTPRequest.h"

@interface ItemDetailAViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UITableView *bbsTableView;
@property NSUInteger pageIndex;
@property NSMutableArray*   pageDataArray;
@end
