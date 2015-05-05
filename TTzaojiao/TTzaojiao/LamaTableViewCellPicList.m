//
//  LamaTableViewCellPicListAndContent.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellPicList.h"
#import "TTBaseViewController.h"
#import "LamaTableViewCellModelFrame.h"
#define  kTextFont  [UIFont systemFontOfSize:15]

@implementation LamaTableViewCellPicList
+ (instancetype)LamaTableViewCellPicListWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCellPicList";
    
    LamaTableViewCellPicList *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCellPicList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //piclist
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        _picListView = imgView;
        
        
//        //content
//        UILabel *name  = [[UILabel alloc]init];
//        [self.contentView addSubview:name];
////        _contentLabel = name;
////        _contentLabel.numberOfLines = 0;
//        name.font = kTextFont;
        
    }
    
    return self;
}

- (void)layoutSubviews{
    if (_modelFrame == nil) {
        _picListView.frame = CGRectMake(0, 0, 375, 286);
    }
    else
    {
    _picListView.frame = _modelFrame.i_PicListFrame;
    }
    

}

- (void)setModelFrame:(LamaTableViewCellModelFrame *)modelFrame
{
    
    _modelFrame = modelFrame;
    //图片数目不定，要计算每个图片的尺寸，以及获得每个图片的url进行显示
    //每张图片的url
    //modelFrame.model.i_pic_list;

}
@end
