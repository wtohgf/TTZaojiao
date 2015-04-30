//
//  TTDynamicPhotosView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicPhotosView.h"

@implementation TTDynamicPhotosView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个子控件
        for (int i = 0; i<9; i++) {
            UIImageView *photoView = [[UIImageView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
//    NSUInteger count = self.photos.count;
//    
//    // 1.封装图片数据
//    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++) {
//        // 一个MJPhoto对应一张显示的图片
//        UIImage * photo = self.subviews[i]; // 来源于哪个UIImageView
//        [myphotos addObject:photo];
//    }
    
    // 2.显示相册
}

-(void)setBlogFrame:(TTBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    BlogModel* mode = blogFrame.blog;
    NSString* picurlstrs = mode.i_pic;
    NSArray* picurls = [picurlstrs componentsSeparatedByString:@"|"];
    NSMutableArray* tmparray = [picurls mutableCopy];
    
    [picurls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:@""]) {
            [tmparray removeObject:obj];
        }
    }];
    
    picurls = tmparray;
    
    [self setPhotos:picurls];
    
    self.frame = blogFrame.photosViewF;
}

-(void)setUserblogFrame:(TTUserBlogFrame *)userblogFrame{
    _userblogFrame = userblogFrame;
    BlogUserDynamicModel* mode = userblogFrame.userblog;
    NSString* picurlstrs = mode.i_pic;
    NSArray* picurls = [picurlstrs componentsSeparatedByString:@"|"];
    NSMutableArray* tmparray = [picurls mutableCopy];
    
    [picurls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:@""]) {
            [tmparray removeObject:obj];
        }
    }];
    
    picurls = tmparray;
    
    [self setPhotos:picurls];
    
    self.frame = userblogFrame.photosViewF;
}


- (void)setPhotos:(NSArray *)photos
{
    
    for (int i = 0; i<self.subviews.count; i++) {
        // 取出i位置对应的imageView
        UIImageView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 设置图片
            //photoView.photo = photos[i];
            [photoView setImageIcon:photos[i]];
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (TTPhotoW + TTPhotoMargin);
            CGFloat photoY = row * (TTPhotoH + TTPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, TTPhotoW, TTPhotoH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }
    }
}

@end
