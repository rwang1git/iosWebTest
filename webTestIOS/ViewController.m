//
//  ViewController.m
//  webTestIOS
//
//  Created by TONY WANG on 14/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "NormalCell.h"
#import "NewsViewController.h"

@interface ViewController ()
{
    NSMutableArray * newsDataArray;
    JSONFileOperate *jsonOper;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/nc/article/list/T1348648756099/0-20.html"];
    
    NSLog(@"[towa]-request start");
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error) {
        NSString *response = [request responseString];
        if(jsonOper == nil)
        {
         jsonOper = [[JSONFileOperate alloc]init];
         jsonOper.delegate = self;
        }
        [jsonOper JSONFileAnalysis:response];
    }
    
    [super viewDidLoad];
    [self.newsTable setDataSource:self];
    [self.newsTable setDelegate:self];
    
    self.newsTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    
    //[self.newsTable.header beginRefreshing];
    //[self ss:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [newsDataArray count];
}

#if 1
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        //HeadCell *cell = [[HeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head" andWithCount:[_headDataArray count]];
        //cell.delegate = self;
        //[cell setContent:_headDataArray];
        return nil;
    }
    //判断有没有图片
    MainPageItems *item = [newsDataArray objectAtIndex:(19-indexPath.row)];
    //if ([item.imgsrc isEqualToString:@""]) {
        NSLog(@"row %@ now! ", @(19-indexPath.row));
      //  NotExistsImageCell *notExistsImageCell = [tableView dequeueReusableCellWithIdentifier:@"NotExistsImage"];
        //if (notExistsImageCell == nil) {
          //  notExistsImageCell = [[NotExistsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotExistsImage"];
        //}
       // [notExistsImageCell setContentWithItem:item];
       // return notExistsImageCell;
    //    return nil;
   // }else{
        NormalCell *normalCell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
        
            //normalCell = [[NormalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
            if( item )
            [normalCell setContentWithItem:[newsDataArray objectAtIndex:(19-indexPath.row)]];
#if 0
        if (isScrolling) {
            NSLog(@"滑动中%d",indexPath.row);
            befRow = nowRow;
            nowRow = indexPath.row;
            [normalCell setContentWIthItemOnlyWordage:[_normolDataArray objectAtIndex:indexPath.row]];
        }
#endif
        
        return normalCell;
   // }
}

//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }
    return 70;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainPageItems *item = [ newsDataArray objectAtIndex:indexPath.row];
    
    //NewsInformationViewController *newsInfoVC = [[NewsInformationViewController alloc]initWithDocid:item.docid];
    //[self.delegate pushViewNewsInfoVC:newsInfoVC];
    //NSLog(@"docid:%@",item.docid);
}
//表代理结束
#endif 

- (void)reloadData
{
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/nc/article/list/T1348648756099/0-20.html"];
    
    NSLog(@"[towa]-request start");
#if 1
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    // add a tag for multi download
    request.tag  = 100;
    [request startAsynchronous];
#endif
}

#pragma mark - table button action
- (IBAction)ss:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/nc/article/list/T1348648756099/0-20.html"];
    
    NSLog(@"[towa]-request start");
#if 1
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    // add a tag for multi download
    request.tag  = 100;
    [request startAsynchronous];
#endif 
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSLog(@"[towa]-request get response");
    NSString *responseString = [request responseString];
    
    //JSONFileOperate *jsonOper = [[JSONFileOperate alloc]init];
    
    //jsonOper.delegate = self;;
    [jsonOper JSONFileAnalysis:responseString];
    
    [self.newsTable.mj_header endRefreshing];
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}

#pragma mark - JSON delegate function
-(void)downLoadFinsh:(NSMutableArray *)headArray andNormalArray:(NSMutableArray *)normalArray
{
    
    newsDataArray = [NSMutableArray arrayWithArray:normalArray];
    
    NSLog(@"[towa]-request start xxx");
    
    [self.newsTable reloadData];
   //[self.newsTable reloadData];
    //从字典中取内容
    //_headDataArray = headArray;
    //_normolDataArray = normalArray;
    //    NSLog(@"head:%@",_headDataArray);
    //    NSLog(@"normal:%@",_normolDataArray);
   // [_tableView reloadData];
   // [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
   // isLoading = NO;
}
- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    if([@"showDetailNews" isEqualToString:segue.identifier])
    {
#if 1
        NewsViewController *newViewController = segue.destinationViewController;
        // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        newViewController.newsUrl = [sender getDetailUrl];
        NSLog(@"prepareForSegue...");
#endif
    }
}


@end
