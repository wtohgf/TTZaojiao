//
//  LamaTableViewCellPicListAndContent.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellPicListAndContent.h"
#import "TTBaseViewController.h"
#import "LamaTableViewCellModelFrame.h"
#define  kTextFont  [UIFont systemFontOfSize:15]
@implementation LamaTableViewCellPicListAndContent
+ (instancetype)LamaTableViewCellPicListAndContentWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCellPicListAndContent";
    
    LamaTableViewCellPicListAndContent *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCellPicListAndContent alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews{
    
    [_picListView setFrame:_modelFrame.i_pic_listFrame];
    [_contentLabel setFrame:_modelFrame.i_contentFrame];
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //piclist
        UIImageView *imgView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:imgView];
        _picListView = imgView;
        
        
        //content
        UILabel *name  = [[UILabel alloc]init];
        [self.contentView addSubview:name];
        _contentLabel = name;
        _contentLabel.numberOfLines = 0;
        name.font = kTextFont;
        
        
    }
    
    return self;
}


- (void)setModelFrame:(LamaTableViewCellModelFrame *)modelFrame
{
    
    _modelFrame = modelFrame;
    
    [_picListView setFrame:_modelFrame.i_pic_listFrame];
    [_contentLabel setFrame:_modelFrame.i_contentFrame];
    _contentLabel.text = modelFrame.model.i_content;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,modelFrame.model.i_pic_list];
    NSArray * tempArray =  [url componentsSeparatedByString:@"|"];
    
    [_picListView setImageWithURL:[NSURL URLWithString: [tempArray firstObject]]];
    
    
     _modelFrame.model.cellType = CellEnumPicListAndContent;
}
@end
