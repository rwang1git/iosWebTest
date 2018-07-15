//
//  MainPageItems.h
//  WXXNews
//
//  Created by qianfeng on 13-6-25.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainPageItems : NSObject
//文档id
@property (nonatomic,copy) NSString *docid;
//提交时间
@property (nonatomic,copy) NSString *ptime;
//标题
@property (nonatomic,copy) NSString *title;
//副标题
@property (nonatomic,copy) NSString *digest;
//是否是再头部显示
@property (nonatomic,copy) NSString *hasHead;
//图片地址
@property (nonatomic,copy) NSString *imgsrc;
//回复数量
@property (nonatomic,copy) NSString *replyCount;
//顺序
@property (nonatomic,copy) NSString *priority;
//内容链接地址
@property (nonatomic,copy) NSString *url;
//标签
@property (nonatomic,copy) NSString *TAG;

//修改时间
@property (nonatomic,copy) NSString *lmodify;
@end
