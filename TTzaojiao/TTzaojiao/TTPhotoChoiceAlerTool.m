//
//  TTPhotoChoiceAlerTool.m
//  TTzaojiao
//
//  Created by hegf on 15-5-21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPhotoChoiceAlerTool.h"
#import <BSImagePickerController.h>
#import "MBProgressHUD+TTHud.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
static TTPhotoChoiceAlerTool* tool;
@implementation TTPhotoChoiceAlerTool

+(instancetype)sharedPhotoChoiceAlerTool{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[TTPhotoChoiceAlerTool alloc]init];
    });
    return tool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}


-(void)photoPickerShowinView:(UIViewController*)vc picCount:(NSInteger)count{
    _vc = vc;
    _maxPicsCount = count;
    UIView* mainView = [[UIView alloc]init];
    mainView.frame = CGRectMake(0, 0, ScreenWidth*0.5, 120.f);
    UIButton* btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0.f, 0.f, ScreenWidth*0.5, 40.f);
    [mainView addSubview:btn];
    btn.tag = 0;
    [btn setTitle:@"相册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(photoChoice:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    
    UIButton* btn2 = [[UIButton alloc]init];
    btn2.frame = CGRectMake(0.f, 40.f, ScreenWidth*0.5, 40.f);
    [mainView addSubview:btn2];
    btn2.tag = 1;
    [btn2 setTitle:@"相机" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(photoChoice:) forControlEvents:UIControlEventTouchUpInside];
    btn2.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [btn2 setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    
    UIButton* btn3 = [[UIButton alloc]init];
    btn3.frame = CGRectMake(0.f, 80.f, ScreenWidth*0.5, 40.f);
    [mainView addSubview:btn3];
    btn3.tag = 2;
    [btn3 setTitle:@"取消" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(photoChoice:) forControlEvents:UIControlEventTouchUpInside];
    btn3.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [btn3 setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    
    CXAlertView* alertView = [[CXAlertView alloc]initWithTitle:@"请选择图片来源:" contentView:mainView cancelButtonTitle:nil];
    _photoChoiceView = alertView;
    [alertView show];

}

-(void)photoChoice:(UIButton*)sender{
    [_photoChoiceView dismiss];
    switch (sender.tag) {
        case 0:
        {
            BSImagePickerController* anImagePicker = [[BSImagePickerController alloc]init];
            anImagePicker.assetType = BSAssetTypeImage;
            anImagePicker.maximumNumberOfImages = _maxPicsCount;
            [_vc presentImagePickerController:anImagePicker
                                      animated:YES
                                    completion:nil
                                        toggle:^(ALAsset *asset, BOOL select) {
//                                            if(select) {
//                                               // NSLog(@"Image selected");
//                                            } else {
//                                               // NSLog(@"Image deselected");
//                                            }
                                        }
                                        cancel:^(NSArray *assets) {
                                            [anImagePicker dismissViewControllerAnimated:YES completion:nil];
                                        } finish:^(NSArray *assets) {
                                            [anImagePicker dismissViewControllerAnimated:YES completion:nil];
                                            NSMutableArray* photos = [NSMutableArray array];
                                            [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                ALAsset* asset = obj;
                                                UIImage *image = [UIImage imageWithCGImage:[[asset  defaultRepresentation]fullScreenImage]];
                                                [photos addObject:image];
                                                
                                            }];
                                            
                                            if ([_delegate respondsToSelector:@selector(didSelectedPhotos:)]) {
                                                [_delegate didSelectedPhotos:photos];
                                            }
                                            
                                        }];

        }
            break;
        case 1:
        {
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [MBProgressHUD TTDelayHudWithMassage:@"相机没有打开" View:_vc.view];
            }else{
                UIImagePickerController* picker = [[UIImagePickerController alloc]init];
                picker.view.backgroundColor = [UIColor orangeColor];
                _picker = picker;
                UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
                picker.sourceType = sourcheType;
                picker.delegate = self;
                picker.allowsEditing = YES;
                [_vc presentViewController:picker animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    NSArray *assets = [NSArray arrayWithObject:chosenImage];
    if ([_delegate respondsToSelector:@selector(didSelectedPhotos:)]) {
        [_delegate didSelectedPhotos:assets];
    }
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

@end
