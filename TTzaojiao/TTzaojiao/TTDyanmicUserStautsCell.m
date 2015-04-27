//
//  TTDyanmicUserStautsCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDyanmicUserStautsCell.h"

@implementation TTDyanmicUserStautsCell
+(instancetype)dyanmicUserStautsCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"dynamicUserStatusCell";
    
    TTDyanmicUserStautsCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDyanmicUserStautsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景色
        self.backgroundColor = TTBlogBackgroundColor;
        
        TTDynamicUserStatusTopView* topView = [[TTDynamicUserStatusTopView alloc]init];
        _topView = topView;
        [self.contentView addSubview:topView];
        
        TTDaynamicUserStatusZancountView* zanCountView = [[TTDaynamicUserStatusZancountView alloc]init];
        _zanCountView = zanCountView;
        [self.contentView addSubview:zanCountView];
    }
    return self;
}

-(void)setBlogFrame:(TTBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    self.contentView.frame = blogFrame.topViewF;
    _topView.blogFrame = blogFrame;
    
    _zanCountView.blogFrame = blogFrame;
    
}
@end
