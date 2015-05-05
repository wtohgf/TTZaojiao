//
//  LamaTableViewCell1.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellNameAndPic.h"

#import "TTBaseViewController.h"
#import "LamaTableViewCellModelFrame.h"
@implementation LamaTableViewCellNameAndPic
+ (instancetype)LamaTableViewCellNameAndPicWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCellNameAndPic";
    
    LamaTableViewCellNameAndPic *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCellNameAndPic alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews{
   
    [_picView setFrame:_modelFrame.i_picFrame];
    [_nameLabel setFrame:_modelFrame.i_nameFrame];


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //pic
        UIImageView *imgView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:imgView];
        _picView = imgView;
        
        
        //name
        UILabel *name  = [[UILabel alloc]init];
        [self.contentView addSubview:name];
        _nameLabel = name;
        _nameLabel.numberOfLines = 0;

        

    }

    return self;
}


- (void)setModelFrame:(LamaTableViewCellModelFrame *)modelFrame
{

        _modelFrame = modelFrame;
    
    [_picView setFrame:_modelFrame.i_picFrame];
    [_nameLabel setFrame:_modelFrame.i_nameFrame];
        _nameLabel.text = modelFrame.model.i_name;
        
        NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,modelFrame.model.i_pic];
        NSArray * tempArray =  [url componentsSeparatedByString:@"|"];
        
        [_picView setImageWithURL:[NSURL URLWithString: [tempArray firstObject]]];

    _modelFrame.model.cellType = CellEnumNameAndPic;

}

@end
