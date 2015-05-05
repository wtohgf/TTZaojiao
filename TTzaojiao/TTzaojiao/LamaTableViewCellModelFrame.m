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
    //if (model.cellType == CellEnumNameAndPic) {
        UIImageView *picView = [[UIImageView alloc]init];
        NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,model.i_pic];
        NSArray * tempArray =  [url componentsSeparatedByString:@"|"];
        [picView setImageWithURL:[NSURL URLWithString: [tempArray firstObject]]];
        CGFloat w = CGImageGetWidth(picView.image.CGImage);
        CGFloat h = CGImageGetHeight(picView.image.CGImage);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = (CGFloat)((width * h)/w) ;
        _i_picFrame = CGRectMake(0, 0, width, height);
        _i_nameFrame = CGRectMake(0, height, width, 60);
        _NameAndPicCellHeight = CGRectGetMaxY(_i_nameFrame);
    //}
    
    //else if (model.cellType == CellEnumPicListAndContent)
   // {
     //算图片list高度
        UIImageView *picView2 = [[UIImageView alloc]init];
      
        //每张图片的url
        NSArray * tempArray2 =  [model.i_pic_list componentsSeparatedByString:@"|"];
        NSMutableArray * heightArray = [NSMutableArray array];
        _heightArray = heightArray;
         CGFloat lastHeight = 0;
        for (NSString * name  in tempArray2) {
            NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,name];
             [picView2 setImageWithURL:[NSURL URLWithString:url]];
            
            CGFloat w = CGImageGetWidth(picView.image.CGImage);
            CGFloat h = CGImageGetHeight(picView.image.CGImage);
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = (CGFloat)((width * h)/w) ;
           
            [heightArray addObject:NSStringFromCGRect(CGRectMake(0, lastHeight, width, height))];
            lastHeight += height;
       // }
        
        _i_pic_listFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, lastHeight);
        
       //算公司描述
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT);
        CGSize  textSize = [model.i_content  sizeWithMaxSize:maxSize andFont:kTextFont];
        _i_contentFrame = CGRectMake(0, lastHeight, [UIScreen mainScreen].bounds.size.width, textSize.height);
        
        //height
        
      
        _PicListAndContentCellHeight = CGRectGetMaxY(_i_contentFrame);

    }
    
    
    
    
}
@end
