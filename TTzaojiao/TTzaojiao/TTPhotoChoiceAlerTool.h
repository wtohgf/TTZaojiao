//
//  TTPhotoChoiceAlerTool.h
//  TTzaojiao
//
//  Created by hegf on 15-5-21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//
#import <CXAlertView.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol TTPhotoChoiceAlerToolDelegate <NSObject>

-(void)didSelectedPhotos:(NSArray*)photos;

@end

@interface TTPhotoChoiceAlerTool : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
+(instancetype)sharedPhotoChoiceAlerTool;

-(void)photoPickerShowinView:(UIViewController*)vc picCount:(NSInteger)count;
@property (weak, nonatomic) UIViewController* vc;
@property (weak, nonatomic) UIImagePickerController* picker;
@property (weak, nonatomic) CXAlertView* photoChoiceView;
@property (assign, nonatomic) NSUInteger maxPicsCount;

@property (weak, nonatomic) id<TTPhotoChoiceAlerToolDelegate> delegate;
@end
