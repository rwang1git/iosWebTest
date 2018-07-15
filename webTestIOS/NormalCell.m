//
//  NormalCell.m
//  WXXNews
//
//  Created by qianfeng on 13-6-25.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "NormalCell.h"

@implementation NormalCell

- (void)dealloc
{
    [_titleLabel release];
    [_mImageView release];
    [_digestLabel release];
    [_replyLable release];
    [_detailUrl release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self makeView];
    }
    return self;
}

-(void)makeView{
    
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    //图片
    _mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 90, 60)];
    _mImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_mImageView];
    [_mImageView release];
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 2, 220, 20)];
    //字号
    _titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel release];
    
    
    //digest
    _digestLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 24, 220, 28)];
    _digestLabel.font = [UIFont systemFontOfSize:12];
    _digestLabel.numberOfLines = 2;
    _digestLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //_digestLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_digestLabel];
    [_digestLabel release];
    
    //reply
    
    _replyLable = [[UILabel alloc]initWithFrame:CGRectMake(240, 54, 75, 14)];
    _replyLable.textAlignment= NSTextAlignmentRight;
    _replyLable.textColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //_replyLable.backgroundColor = [UIColor yellowColor];
    _replyLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_replyLable];
    [_replyLable release];
}
-(void)setContentWithItem:(MainPageItems *)item{
    _titleLabel.text = item.title;
    _digestLabel.text = item.digest;
    _replyLable.text = [NSString stringWithFormat:@"%@ 跟帖",item.replyCount];
    _mImageView.image = nil;
    [self.textLabel setFont:[UIFont boldSystemFontOfSize:13]];
    self.textLabel.text = item.title;
    _detailUrl = item.url;
    
   // NSLog(@"imgsrc:%@",item.imgsrc);
    //判断缓存是否存在
    //NSData *data = [CacheOperate readDataWithURLStr:item.imgsrc];
    {
        //下载图片
        ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:item.imgsrc]];
        request.delegate = self;
        [request startSynchronous];
        
        NSError *error = [request error];
        
        if (!error) {
            _mImageView.image = [UIImage imageWithData:request.responseData];
            self.image = [UIImage imageWithData:request.responseData];
        }
    }
}
-(void)setContentWIthItemOnlyWordage:(MainPageItems *)item{
    _titleLabel.text = item.title;
    _digestLabel.text = item.digest;
    _replyLable.text = [NSString stringWithFormat:@"%@ 跟帖",item.replyCount];
        _mImageView.image = nil;
#if 0
    NSData *data = [CacheOperate readDataWithURLStr:item.imgsrc];
    if (data != nil) {
        _mImageView.image = [UIImage imageWithData:data];
    }else{
        _mImageView.image = nil;
    }
#endif
}
-(void)setImageWithURLString:(NSString *)urlStr{
    //判断缓存是否存在
    //NSData *data = [CacheOperate readDataWithURLStr:urlStr];
        //下载图片
        ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
        request.delegate = self;
        [request startSynchronous];
        NSError *error = [request error];
        
        if (!error) {
            _mImageView.image = [UIImage imageWithData: request.responseData];
        }
}

-(NSString *)getDetailUrl
{
    return _detailUrl;

}
#if 0
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#endif
@end
