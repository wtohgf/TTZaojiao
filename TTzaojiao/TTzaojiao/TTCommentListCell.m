//
//  TTCommentListCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTCommentListCell.h"

@implementation TTCommentListCell
+(instancetype)commentListCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"commentListCell";
    
    TTCommentListCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景色
        self.backgroundColor = TTBlogBackgroundColor;
        
        TTDynamicCommentView* commentView = [[TTDynamicCommentView alloc]init];
        [self.contentView addSubview:commentView];
        _commentView = commentView;
    }
    return self;
}

-(void)setCommentFrame:(TTCommentFrame *)commentFrame{
    _commentFrame = commentFrame;
    _commentView.commentFrame = commentFrame;
}

@end
