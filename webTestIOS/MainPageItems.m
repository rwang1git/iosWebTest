//
//  MainPageItems.m
//  WXXNews
//
//  Created by qianfeng on 13-6-25.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "MainPageItems.h"

@implementation MainPageItems
- (void)dealloc
{
    [_docid release];
    [_ptime release];
    [_title release];
    [_digest release];
    [_hasHead release];
    [_imgsrc release];
    [_replyCount release];
    [_priority release];
    [_url release];
    [_TAG release];
    [_lmodify release];
    [super dealloc];
}
@end
