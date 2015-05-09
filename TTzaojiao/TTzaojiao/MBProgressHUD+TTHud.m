//
//  MBProgressHUD+TTHud.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "MBProgressHUD+TTHud.h"

@implementation MBProgressHUD (TTHud)

+(void)TTDelayHudWithMassage:(NSString *)massage View:(UIView *)view {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        HUD.yOffset = view.frame.size.height*2/5;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = massage;
        [HUD show:YES];
        [HUD hide:YES afterDelay: 1.f];

}

@end
