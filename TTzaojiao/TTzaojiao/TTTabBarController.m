//
//  TTTabBarController.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTUserModelTool.h"
#import "TTUIChangeTool.h"

@implementation TTTabBarController
#pragma mark Tabbar

- (instancetype)init
{
    if (self = [super init]) {
        [self setupViewControllers];
        self.rdv_tabBarController.tabBar.delegate = self;
    }
    return self;
}
- (void)setupViewControllers {
    UIStoryboard *storyBoardZaoJiao=[UIStoryboard storyboardWithName:@"ZaoJiaoStoryboard" bundle:nil];
    UIViewController *zaojiaoNavigationController = [storyBoardZaoJiao instantiateViewControllerWithIdentifier:@"ZaoJiaoNav"];
    
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    UIViewController *dongtaiNavigationController = [storyBoardDongTai instantiateViewControllerWithIdentifier:@"DongTaiNav"];
    
    UIStoryboard *storyBoardLaMaJie=[UIStoryboard storyboardWithName:@"LaMaJieStoryboard" bundle:nil];
    UIViewController *lamajieNavigationController = [storyBoardLaMaJie instantiateViewControllerWithIdentifier:@"LaMaJieNav"];
    
    UIStoryboard *storyBoardWo=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
    UIViewController *woNavigationController = [storyBoardWo instantiateViewControllerWithIdentifier:@"WoNav"];
    
    
    
    [self setViewControllers:@[zaojiaoNavigationController,
                                           dongtaiNavigationController,
                                           lamajieNavigationController,
                                           woNavigationController]];
   
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(TTTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"bottom_btn1", @"bottom_btn2", @"bottom_btn4", @"bottom_btn5"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_checked",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_unchecked",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                           };
        
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor colorWithRed:181.f/255.f green:64.f/355.f blue:92.f/255.f alpha:1],
                                         };
        
        switch (index) {
            case 0:
            {
                [item setTitle:@"早教"];
            }
                break;
            case 1:
            {
                [item setTitle:@"动态"];
            }
                break;
            case 2:
            {
                [item setTitle:@"辣妈街"];
            }
                break;
            case 3:
            {
                [item setTitle:@"我"];
            }
                break;
                
            default:
                break;
        }
        
        index++;
    }
    
    self.selectedIndex = 0;
}

- (void)customizeInterface {
    //    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    //
    //    UIImage *backgroundImage = nil;
    //    NSDictionary *textAttributes = nil;
    //
    //    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
    //        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
    //
    //        textAttributes = @{
    //                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
    //                           NSForegroundColorAttributeName: [UIColor blackColor],
    //                           };
    //    } else {
    //#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    //        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
    //
    //        textAttributes = @{
    //                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
    //                           UITextAttributeTextColor: [UIColor blackColor],
    //                           UITextAttributeTextShadowColor: [UIColor clearColor],
    //                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
    //                           };
    //#endif
    //    }
    //
    //    [navigationBarAppearance setBackgroundImage:backgroundImage
    //                                  forBarMetrics:UIBarMetricsDefault];
    //    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


-(BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index{
    if (index == 3) {
        if ([[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
            UIAlertView* alertView =  [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册登录后可以查看我的信息\n还有宝宝的成长测评等等" delegate:self cancelButtonTitle:@"以后吧" otherButtonTitles:@"登录注册",nil];
            [alertView show];
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            [[TTUIChangeTool sharedTTUIChangeTool]backToLogReg:self.navigationController];
        }
            break;
        default:
            break;
    }
}

@end
