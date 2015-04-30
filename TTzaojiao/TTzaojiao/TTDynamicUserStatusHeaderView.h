//
//  TTDynamicUserStatusHeaderView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kChangeIcon = 0,
    kzanCover,
    kChangeCover,
    kBack
}ActionType;
@class TTDynamicUserStatusHeaderView;
@protocol TTDynamicUserStatusHeaderViewDelegate <NSObject>

-(void)dynamicHeaderView:(TTDynamicUserStatusHeaderView*)headerView didActionType:(ActionType)type;

@end
@interface TTDynamicUserStatusHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UIView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *sepintr;
@property (weak, nonatomic) IBOutlet UILabel *genderMounth;

@property (weak, nonatomic) id<TTDynamicUserStatusHeaderViewDelegate> delegate;
@end
