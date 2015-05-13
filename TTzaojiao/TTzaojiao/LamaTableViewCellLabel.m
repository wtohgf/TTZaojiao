//
//  LamaTableViewCellLabel.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellLabel.h"
#import "LamaTableViewCellModelFrame.h"

#define  kTextFont  [UIFont systemFontOfSize:17]

@implementation LamaTableViewCellLabel


+ (instancetype)LamaTableViewCellContactWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCellLabel";
    
    LamaTableViewCellLabel *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCellLabel alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //cell.backgroundColor = [UIColor purpleColor];
    return cell;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    [_label setFrame:CGRectMake(8, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //label
        UILabel *label  = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        _label = label;
        _label.font = kTextFont;
        
        // _label.text = @"活动详情";
    }
    
    return self;
}


//- (void)setModelFrame:(LamaTableViewCellModelFrame *)modelFrame
//{
//
//
//
//
//}
@end
