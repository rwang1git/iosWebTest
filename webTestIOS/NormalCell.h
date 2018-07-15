//
//  NormalCell.h
//  WXXNews
//
//  Created by qianfeng on 13-6-25.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageItems.h"
#import "ASIHTTPRequest.h"
//#import "CacheOperate.h"

@interface NormalCell : UITableViewCell<ASIHTTPRequestDelegate>

@property (nonatomic,retain) UIImageView *mImageView;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *digestLabel;

@property (nonatomic,retain) UILabel *replyLable;
@property (nonatomic,retain) NSString *detailUrl;

-(void)setContentWithItem:(MainPageItems *)item;

-(void)setContentWIthItemOnlyWordage:(MainPageItems *)item;

-(NSString *)getDetailUrl;

-(void)setImageWithURLString:(NSString *)urlStr;
@end
