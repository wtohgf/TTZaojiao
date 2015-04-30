//
//  TTDynamicPhotosView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogModel.h"
#import "BlogUserDynamicModel.h"
#import "UIImageView+MoreAttribute.h"
#import "TTBlogFrame.h"
#import "TTUserBlogFrame.h"

@interface TTDynamicPhotosView : UIView
/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (strong, nonatomic) TTUserBlogFrame* userblogFrame;
//@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
@end
