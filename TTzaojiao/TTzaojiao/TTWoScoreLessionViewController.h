//
//  TTWoScoreLessionViewController.h
//  TTzaojiao
//
//  Created by hegf on 15-5-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import "DynamicUserModel.h"

@interface TTWoScoreLessionViewController : TTBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreCount;
@property (weak, nonatomic) IBOutlet UITextField *lessionAccount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLessionType;
@property (strong, nonatomic) DynamicUserModel* Wo;
@end
