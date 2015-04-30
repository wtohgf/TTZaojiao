//
//  TTDynamicUserBlogCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTUserBlogFrame.h"
#import "TTDynamicUserStatusTopView.h"
#import "TTDaynamicUserStatusZancountView.h"
#import "TTDynamicPhotosView.h"

@class TTDynamicUserBlogCell;
@protocol TTDynamicUserBlogCellDelegate<NSObject>
-(void)dynamicUserBlogCell:(TTDynamicUserBlogCell*)cell didShowCommentList:(NSString*)blog_id;
@end


@interface TTDynamicUserBlogCell : UITableViewCell

@property (weak, nonatomic) TTDynamicUserStatusTopView* topView;
@property (weak, nonatomic) TTDynamicPhotosView* photosView;
@property (weak, nonatomic) TTDaynamicUserStatusZancountView* zanCountView;

@property (strong, nonatomic) TTUserBlogFrame* blogFrame;
@property (weak, nonatomic) UIButton* showAllReplayButton;

@property (weak, nonatomic) id<TTDynamicUserBlogCellDelegate> delegate;

+(instancetype)dyanmicUserBlogCellWithTableView:(UITableView *)tableView;

@end
