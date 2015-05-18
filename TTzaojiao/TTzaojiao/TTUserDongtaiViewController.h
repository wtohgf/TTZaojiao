//
//  TTUserDongtaiViewController.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import "DynamicUserModel.h"
#import "TTDynamicUserStatusHeaderView.h"
#import "UIImageView+MoreAttribute.h"
#import "TTUserBlogFrame.h"
#import "TTDynamicUserBlogCell.h"
#import "TTCommentListViewController.h"
#import "NSString+Extension.h"
#import <JSImagePickerViewController.h>
#import "UIImage+MoreAttribute.h"
#import "UIImageView+MoreAttribute.h"

@interface TTUserDongtaiViewController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate, TTDynamicUserStatusHeaderViewDelegate, TTDynamicUserBlogCellDelegate,
    JSImagePickerViewControllerDelegate,UIAlertViewDelegate>
@property (copy, nonatomic) NSString * i_uid;

@end
