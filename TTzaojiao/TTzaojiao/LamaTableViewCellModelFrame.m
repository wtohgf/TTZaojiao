//
//  LamaTableViewCellModelFrame.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellModelFrame.h"
#import "TTBaseViewController.h"
#import "NSString+Extension.h"
#define  kTextFont  [UIFont systemFontOfSize:15]

@implementation LamaTableViewCellModelFrame
- (void)setModel:(LaMaDetailModel *)model
{
    
    _model = model;
    
    //算公司名称和公司图片高度
    UIImageView *picView = [[UIImageView alloc]init];
    picView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,model.i_pic];
    NSArray * tempArray =  [url componentsSeparatedByString:@"|"];
    [picView setImageWithURL:[NSURL URLWithString: [tempArray firstObject]]];
    CGFloat w = CGImageGetWidth(picView.image.CGImage);
    CGFloat h = CGImageGetHeight(picView.image.CGImage);

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = (CGFloat)((width * 3)/4) ;
    if (w != 0 && h != 0) {
        height = (CGFloat)((width * h)/w) ;
    }
    _i_picFrame = CGRectMake(0, 0, width, height);
    _i_nameFrame = CGRectMake(8, height, width-16, 30);
    _NameAndPicCellHeight = CGRectGetMaxY(_i_nameFrame);
    
    
    //算图片list高度
    UIImageView *picView2 = [[UIImageView alloc]init];
    picView2.contentMode = UIViewContentModeScaleAspectFill;
    //每张图片的url
    NSArray * picListArray =  [model.i_pic_list componentsSeparatedByString:@"|"];
    NSMutableArray * heightArray = [NSMutableArray array];
    CGFloat lastHeight = 0;
    for (NSString * name  in picListArray) {
        NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,name];
        [picView2 setImageWithURL:[NSURL URLWithString:url]];
        CGFloat w = CGImageGetWidth(picView2.image.CGImage);
        CGFloat h = CGImageGetHeight(picView2.image.CGImage);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = (CGFloat)((width * 3)/4) ;
        if (w != 0 && h != 0) {
            height = (CGFloat)((width * h)/w) ;
        }

        [heightArray addObject:NSStringFromCGRect(CGRectMake(0, lastHeight, width, height))];
        lastHeight += height;
        
    }
    _i_PicListFrame = CGRectMake(0, 0, width, height+8);
    _picListArray = picListArray;
    _model.count =  (int)heightArray.count;
    _model.count += 3;
    
    //算公司描述
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-8*2, MAXFLOAT);
    CGSize  textSize = [model.i_content  sizeWithMaxSize:maxSize andFont:kTextFont];
    _i_contentFrame = CGRectMake(8, 0, [UIScreen mainScreen].bounds.size.width-8*2, textSize.height);
    
}
@end
