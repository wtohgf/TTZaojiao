//
//  LaMaAddRegCompayViewController.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"

@interface LaMaAddRegCompayViewController : TTBaseViewController<UITextFieldDelegate>
@property (weak, nonatomic)  UITextField *compayNameTextField;
@property (weak, nonatomic)  UITextField *contactNameField;
@property (weak, nonatomic)  UITextField *telField;
@end
