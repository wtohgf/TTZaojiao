//
//  TTDongtaiPicsTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-25.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongtaiPicsTableViewCell.h"

@implementation TTDongtaiPicsTableViewCell

+(instancetype)dongtaiPicsTableViewCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"picsCell";
    
    TTDongtaiPicsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDongtaiPicsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.icons = [NSMutableArray array];
    return cell;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBlogModel:(BlogModel *)blogModel{
    [_icons removeAllObjects];
    for (UIView* imageView in self.backView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            [imageView removeFromSuperview];
        }
    }
    NSArray* picsArray = nil;
    if (blogModel.i_pic.length != 0) {
        picsArray = [blogModel.i_pic componentsSeparatedByString:@"|"];
    }
    if (picsArray != nil && picsArray.count > 1) {
        [picsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* picpath = obj;
            if (picpath.length > 0) {
                UIImageView *imageView = [[UIImageView alloc]init];
                NSString* str = [NSString stringWithFormat:@"%@%@",TTBASE_URL,picpath];
                [imageView setImageWithURL:[NSURL URLWithString:str]];
                [self.backView addSubview:imageView];
                [_icons addObject:imageView];
            }else{
                *stop = YES;
            }
            
        }];
    }
    [self setPicsFrame];
    _blogModel = blogModel;

}

-(void)setPicsFrame{
 
    __block NSUInteger totalloc = 3;
    CGFloat headerX = 8.f;
    CGFloat headerY = 2.f;
    CGFloat iconW = 80.f;
    CGFloat iconH = 80.f;
    CGFloat margin = 2.f;
    
    [_icons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView* imageView = obj;
        NSUInteger row = idx/totalloc;//行号
                 //1/3=0,2/3=0,3/3=1;
        NSUInteger loc=idx%totalloc;//列号
        
        CGFloat iconX = headerX+(margin+iconW)*loc;
        CGFloat iconY = headerY+(margin+iconH)*row;
        
        imageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
    
    if (_icons.count == 0) {
        _cellheight.constant = 2*headerY;
    }else if(_icons.count > 0 && _icons.count <=3){
        _cellheight.constant = 2*headerY+iconH+margin;
    }else if(_icons.count > 3 && _icons.count <=6){
        _cellheight.constant = 2*headerY+(iconH+margin)*2;
    }else if(_icons.count > 6 && _icons.count <=9){
        _cellheight.constant = 2*headerY+(iconH+margin)*3;
    }

}

@end
