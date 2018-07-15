//
//  ItemDetailAViewController.m
//  webTestIOS
//
//  Created by TONY WANG on 24/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//

#import "ItemDetailAViewController.h"
#import "TFHpple.h"
#import "MJRefresh.h"
#import "BbsViewController.h"
#import "AFNetworking.h"

@interface ItemDetailAViewController ()
{
NSArray *arrayTitle;
NSArray *arrayTitleUrl;
}

@end

@implementation ItemDetailAViewController

@synthesize pageIndex;
@synthesize pageDataArray;



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bbsTableView setDataSource:self];
    [self.bbsTableView setDelegate:self];
    pageDataArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil];
    self.bbsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self downData];
    NSLog(@"init done");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [pageDataArray[self.pageIndex-1] intValue];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断有没有图片
    NSLog(@"row %@-%@-%@ now! ", @(indexPath.row),((TFHppleElement *)arrayTitle[indexPath.row]).content,((TFHppleElement *)arrayTitleUrl[indexPath.row]).content);
    
    //  NotExistsImageCell *notExistsImageCell = [tableView dequeueReusableCellWithIdentifier:@"NotExistsImage"];
    //if (notExistsImageCell == nil) {
    //  notExistsImageCell = [[NotExistsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotExistsImage"];
    //}
    // [notExistsImageCell setContentWithItem:item];
    // return notExistsImageCell;
    //    return nil;
    // }else{
    UITableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:@"bbscell"];
    if( !normalCell )
    {
        normalCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bbscell"];
    }
     [normalCell.textLabel setText:((TFHppleElement *)arrayTitle[indexPath.row]).content];

    return normalCell;
    // }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(void)refreshData{
    [self downData];
    [self.bbsTableView reloadData];
    [self.bbsTableView.mj_header endRefreshing];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BbsViewController *newViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"bbsWebView"];
    if(pageIndex == 1)
    {
    NSString *tmpStr=@"http://m.kdslife.com/";
    newViewController.bbsUrl = [[tmpStr stringByAppendingString:((TFHppleElement *)arrayTitleUrl[[indexPath row]]).content] mutableCopy];
    }
    
    if(pageIndex == 2)
    {
    NSString *tmpStr=@"http://wap.libaclub.com/";
    newViewController.bbsUrl = [[tmpStr stringByAppendingString:((TFHppleElement *)arrayTitleUrl[[indexPath row]]).content] mutableCopy];
    }
   
    if(pageIndex == 3)
    {
        NSString *tmpStr=@"https://weibo.com/?category=0";
        newViewController.bbsUrl = [[tmpStr stringByAppendingString:((TFHppleElement *)arrayTitleUrl[[indexPath row]]).content] mutableCopy];
    }
    
    
    NSLog(@"bbs new URL is %@",newViewController.bbsUrl);
    newViewController.savedVc = self ;
    [self presentViewController:newViewController animated:YES completion: nil];
}

#if 0

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    if([@"showDetailBbs" isEqualToString:segue.identifier])
    {
        
        UINavigationController *vcNav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"bbsNav"];
        [vcNav pushViewController:self animated:YES];
        BbsViewController *newViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.bbsTableView indexPathForSelectedRow];
        NSString *tmpStr=@"http://m.kdslife.com/";
        newViewController.bbsUrl = [tmpStr stringByAppendingString:((TFHppleElement *)arrayTitleUrl[[indexPath row]]).content];
        NSLog(@"prepareForSegue...");
        [self presentViewController:newViewController animated:YES completion: nil];
        //[self.navigationController pushViewController:newViewController animated:YES];
    }
}
#endif

- (void)downData{
    NSArray *webSite = @[@"http://www.kdslife.com/f_15.html",@"https://wap.libaclub.com/s_9.htm",@"http://weibo.com/?category=0"];
    //NSLog(@"Page index is %@",self.pageIndex);
    NSURL *url = [NSURL URLWithString:webSite[pageIndex-1]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error && pageIndex == 1) {
        [request startSynchronous];
        NSString *response = [request responseString];
        NSRange rang1=[response rangeOfString:@"<span class=\"n3\">主题<"];
        NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[response substringFromIndex:rang1.location+rang1.length]];
        NSRange rang2=[imageStr2 rangeOfString:@"<li class=\"i3\">"];
        NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
        
        NSLog(@"%@",imageStr3);
        NSData *data=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data];
        // 根据标签进行筛选 获取所有标签是<title> array
        //<span class="n3">
        //<a rel="https://club-img.kdslife..jpg" href="t_9699529.html" title="为什么要封门面房？">为什么要封门面房？</a>
        //<img src="ui/img/bg_h.png" data-bd-imgshare-binded="1">
        //p ((TFHppleElement *)arrayTitleUrl[0]).content
        //(__NSCFString *) $5 = 0x00006100002214e0 @"t_9699934.html"
        
        arrayTitle = [xpathParser searchWithXPathQuery:@"//span [@class= 'n3']/a/attribute::title"];
        arrayTitleUrl = [xpathParser searchWithXPathQuery:@"//span [@class= 'n3']/a[1]/attribute::href"];
        [pageDataArray replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:[arrayTitle count]]];
        NSLog(@"KDS parse done");
    
    }
    
    if (!error && pageIndex == 2) {
        [request startSynchronous];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSRange rang1=[response rangeOfString:@"<div class=\"ui-box-content\">"];
        NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[response substringFromIndex:rang1.location+rang1.length]];
        NSRange rang2=[imageStr2 rangeOfString:@"<div class=\"ui-footer\">"];
        NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
        
        NSLog(@"%@",imageStr3);
        NSData *data=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data];
        //<img src="ui/img/bg_h.png" data-bd-imgshare-binded="1">
        //p ((TFHppleElement *)arrayTitleUrl[0]).content
        //(__NSCFString *) $5 = 0x00006100002214e0 @"t_9699934.html"
        
        arrayTitle = [xpathParser searchWithXPathQuery:@"//p [@class='ui-list-item-title']/a[1]"];
        arrayTitleUrl = [xpathParser searchWithXPathQuery:@"//p [@class='ui-list-item-title']/a[1]/attribute::href"];
        [pageDataArray replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:[arrayTitle count]]];
        NSLog(@"liba parse done");
    }
    
   if (!error && pageIndex == 3)
   {
        __block NSString *  response;
        dispatch_queue_t queue = dispatch_queue_create("gcdtest", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue,^{
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            __block dispatch_semaphore_t aSema = dispatch_semaphore_create(0);
            
            //default is json, so set general serializer
            //importent
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:56.0) Gecko/20100101 spider Firefox/56.0" forHTTPHeaderField:@"User-Agent"];
            
            [manager GET:@"https://weibo.com/?category=0" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress){
                NSLog(@"downloading....");
            }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if(responseObject)
                {
                    //NSStringEncoding  gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                    response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"%@", response);
                    dispatch_semaphore_signal(aSema);
                }
                NSLog(@"download ok");
                
            }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
                NSLog(@"%@",error);  //这里打印错误信息
                dispatch_semaphore_signal(aSema);
            }];
            dispatch_semaphore_wait(aSema, DISPATCH_TIME_FOREVER);
        });
        
        dispatch_barrier_async(queue,^{
            NSLog(@"%@",response);
        });
        
        dispatch_barrier_async(queue,^{
            NSLog(@"Here is another continue!");
        
        NSRange rang1=[response rangeOfString:@"UG_slider"];
        NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[response substringFromIndex:rang1.location+rang1.length]];
        NSRange rang2=[imageStr2 rangeOfString:@"10005"];
        NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
        
        NSLog(@"%@",imageStr3);
        NSData *data=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data];
        //<img src="ui/img/bg_h.png" data-bd-imgshare-binded="1">
        //p ((TFHppleElement *)arrayTitleUrl[0]).content
        //(__NSCFString *) $5 = 0x00006100002214e0 @"t_9699934.html"
        
        arrayTitle = [xpathParser searchWithXPathQuery:@"//p [@class='list_title_s']/div[1]"];
        arrayTitleUrl = [xpathParser searchWithXPathQuery:@"//p [@class='list_title_s']/div[1]/attribute::href"];
        [pageDataArray replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:[arrayTitle count]]];
        NSLog(@"liba parse done");
        });
   }}
         
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
