//
//  LamaTableViewCellContent.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellContent.h"
#import "LamaTableViewCellModelFrame.h"

#define  kTextFont  [UIFont systemFontOfSize:15]

@implementation LamaTableViewCellContent
+ (instancetype)LamaTableViewCellContentWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCellContent";
    
    LamaTableViewCellContent *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCellContent alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //cell.backgroundColor = [UIColor greenColor];
    return cell;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];

    [_contentLabel setFrame:_modelFrame.i_contentFrame];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //content
        UILabel *contentLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = kTextFont;
        
    }
    
    return self;
}


- (void)setModelFrame:(LamaTableViewCellModelFrame *)modelFrame
{    
    _modelFrame = modelFrame;
    _contentLabel.text = modelFrame.model.i_content;
    
}

@end
