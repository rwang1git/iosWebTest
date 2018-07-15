//
//  ItemsPageVC.m
//  webTestIOS
//
//  Created by TONY WANG on 24/12/2017.
//  Copyright © 2017 tonywang. All rights reserved.
//

#import "ItemsPageVC.h"
#import "ItemDetailAViewController.h"

@interface ItemsPageVC ()

@end

@implementation ItemsPageVC

#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_pageTitles) {
        _pageTitles = @[@"KDS", @"LiBa",@"WeiBo"];
    }
    return _pageTitles;
}
#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {
        
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
    }
    return self;
}

#pragma mark - Datasource & Delegate

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    switch (index) {
        case 0:{
            
            ItemDetailAViewController   *vcClass = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"];
            vcClass.pageIndex=1;
            return vcClass;
            
        }
            
            break;
        case 1:{
            
            ItemDetailAViewController *vcClass = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"];
            vcClass.pageIndex=2;
            return vcClass;
            
        }
            
            break;
            
        case 2:{
            
            ItemDetailAViewController *vcClass = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"];
            vcClass.pageIndex=3;
            return vcClass;
            
        }
            
        default:
            break;
    }
    return nil;
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
*/



@end
