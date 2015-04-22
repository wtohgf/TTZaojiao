//
//  TTRealRegisitViewController.h
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import "JSImagePickerViewController.h"
#import "TSLocateView.h"
#import "CustomDatePicker.h"

@interface TTRealRegisitViewController : TTBaseViewController<JSImagePickerViewControllerDelegate, UIActionSheetDelegate>
//第一步传过来的
@property (copy, nonatomic) NSString* phoneNum;
@property (copy, nonatomic) NSString* password;

@end
