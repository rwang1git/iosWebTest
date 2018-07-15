//
//  CacheOperate.h
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-26.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Hashing.h"


@interface CacheOperate : NSObject
//写缓存
+(void)writeCacheWithURLStr:(NSString *)str andWithData:(NSData *)data;
//读取缓存
+(NSData *)readDataWithURLStr:(NSString *)str;

@end
