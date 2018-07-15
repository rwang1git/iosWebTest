//
//  CacheOperate.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-26.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "CacheOperate.h"

@implementation CacheOperate
//缓存操作
+(void)writeCacheWithURLStr:(NSString *)str andWithData:(NSData *)data{
    NSString *path = [NSString stringWithFormat:@"%@/tmp/%@",NSHomeDirectory(),[str MD5Hash]];
    [data writeToFile:path atomically:NO];
}

//读取缓存
+(NSData *)readDataWithURLStr:(NSString *)str{
    NSString *path = [NSString stringWithFormat:@"%@/tmp/%@",NSHomeDirectory(),[str MD5Hash]];
    //判断文件是否存在
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        return data;
    }
    return nil;
    
}
@end
