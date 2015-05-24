//
//  TTDyanmicUserStautsCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "TTDynamicUserStatusTopView.h"
#import "TTDaynamicUserStatusZancountView.h"
#import "TTDynamicPhotosView.h"
#import "TTDynamicCommentsView.h"
#import "TTCommentFrame.h"
@class TTDyanmicUserStautsCell;
@protocol TTDyanmicUserStautsCellDelegate<NSObject>
-(void)dynamicUserStatusTopView:(TTDynamicUserStatusTopView*)view didIconTaped:(NSString*)uid;

-(void)daynamicUserStatusZanClicked:(NSString*)blogid;
-(void)dynamicCell:(TTDyanmicUserStautsCell*) cell UserStatusRemsgClicked:(NSString*)blogid;

-(void)dynamicCell:(TTDyanmicUserStautsCell*)cell didShowCommentList:(NSString*)blog_id;
@end


@interface TTDyanmicUserStautsCell : UITableViewCell

@property (weak, nonatomic) TTDynamicUserStatusTopView* topView;
@property (weak, nonatomic) TTDynamicPhotosView* photosView;
@property (weak, nonatomic) TTDaynamicUserStatusZancountView* zanCountView;
@property (weak, nonatomic) TTDynamicCommentsView* commentsView;
@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (strong, nonatomic) NSArray* commentsFrame;

+(instancetype)dyanmicUserStautsCellWithTableView:(UITableView *)tableView;


@property (weak, nonatomic) id<TTDyanmicUserStautsCellDelegate> delegate;
@end
