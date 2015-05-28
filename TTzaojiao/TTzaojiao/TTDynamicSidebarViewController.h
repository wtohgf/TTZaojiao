//
//  TTDynamicSidebarViewController.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/5.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LLBlurSidebar.h"

@class TTDynamicSidebarViewController;
@protocol TTDynamicSidebarViewControllerDelegate<NSObject>
-(void)slider:(TTDynamicSidebarViewController*)slider didselAgeGroup:(NSString*)group;
@end
@interface TTDynamicSidebarViewController : LLBlurSidebar
@property (weak, nonatomic) id<TTDynamicSidebarViewControllerDelegate> delegate;
@end
