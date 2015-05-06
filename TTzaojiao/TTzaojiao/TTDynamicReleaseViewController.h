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
#import "JSImagePickerViewController.h"
#import "NSAttributedString+EmojiExtension.h"

@interface TTDynamicReleaseViewController : TTBaseViewController<TTPublichViewDelegate,JSImagePickerViewControllerDelegate>

@property (weak, nonatomic) TTPublichView *bottomBar;
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) TTPublichPicsView* publichPicsView;
@property (strong, nonatomic) CLLocation* location;

@end
