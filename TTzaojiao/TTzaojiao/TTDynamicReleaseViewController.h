//
//  TTDynamicReleaseViewController.h
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import "TTPublichView.h"
#import "TTPublichPicsView.h"
#import "NSAttributedString+EmojiExtension.h"
#import "TTPhotoChoiceAlerTool.h"

@interface TTDynamicReleaseViewController : TTBaseViewController<TTPublichViewDelegate,TTPhotoChoiceAlerToolDelegate>

@property (weak, nonatomic) TTPublichView *bottomBar;
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) TTPublichPicsView* publichPicsView;
@property (strong, nonatomic) CLLocation* location;
@property (copy, nonatomic) NSString * activeID;

@property (copy, nonatomic) NSString * sort; //1 早教自拍 2课程提问 3宝宝生活
@end
