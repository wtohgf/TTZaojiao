//
//  TTZaojiaLessionCellView.h
//  TTzaojiao
//
//  Created by hegf on 15-5-20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "UIView+NKMoreAttribute.h"

#define kCellHeight 132.f
#define kTitleRatio 0.6

@interface TTZaojiaLessionCellView : UIView

@property (weak, nonatomic)  UIImageView *lessionImage;
@property (weak, nonatomic)  UILabel *lessionTitle;
@property (weak, nonatomic)  UILabel *lessionIntroduce;
@property (weak, nonatomic)  UILabel *babyCount;
@property (weak, nonatomic)  UILabel *commentCount;
@property (strong, nonatomic) NSMutableArray* imageViews;
@property (weak, nonatomic) UIImageView* rightIcon;
@property (weak, nonatomic) UIButton* startPlayButton;

@end
