//
//  CustomDatePicker.h
//  TTzaojiao
//
//  Created by hegf on 15-4-22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol CustomDatePickerDelegate<NSObject>

@end

@interface CustomDatePicker : UIActionSheet
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *toptitle;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate;
- (void)showInView:(UIView *) view;

@end
