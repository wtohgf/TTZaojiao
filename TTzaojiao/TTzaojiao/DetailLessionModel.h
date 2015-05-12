//
//  DetailLessionModel.h
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "active_buzhou" = "\U5988\U5988\U5750\U5728\U57ab\U5b50\U4e0a\U53cc\U817f\U5408\U62e2\Uff0c\U4f38\U76f4\Uff0c\U811a\U5c16\U524d\U4f38\Uff0c\U8ba9\U5b9d\U5b9d\U4ef0\U8eba\U5728\U5988\U5988\U7684\U53cc\U817f\U4e2d\U95f4\Uff0c\U53cc\U624b\U6293\U4f4f\U5b9d\U5b9d\U7684\U53cc\U81c2\U3002\U5438\U6c14\Uff1b\U5988\U5988\U5c06\U53cc\U817f\U6162\U6162\U62ac\U8d77\Uff0c\U5b9d\U5b9d\U53cc\U817f\U9876\U4f4f\U5988\U5988\U7684\U8179\U90e8\Uff0c\U8f7b\U8f7b\U5730\U62ac\U523045\U5ea6\U89d2\U3002\Uff08\U4fdd\U6301\U4e00\U4f1a\Uff09\U547c\U6c14\Uff1b\U5988\U5988\U6293\U7740\U5b9d\U5b9d\U7684\U53cc\U81c2\Uff0c\U53cc\U817f\U56de\U5230\U539f\U4f4d\U3002\U91cd\U590d4\U6b21\U3002\Uff08\U6bcf\U6b21\U90fd\U8981\U9002\U5f53\U63d0\U9ad8\U4e0a\U62ac\U9ad8\U5ea6\Uff09\U4e00\U8282\U64cd\U7ed3\U675f\Uff0c\U5988\U5988\U5c06\U5b9d\U5b9d\U62b1\U5230\U6000\U4e2d\Uff0c\U8f7b\U8f7b\U629a\U6478\Uff0c\U8fd9\U65f6\U5b9d\U5b9d\U4f1a\U5f88\U8212\U670d\U3002";
 "active_id" = 268;
 "active_mubiao" = "\U901a\U8fc7\U7ec3\U745c\U4f3d\U51cf\U9664\U5988\U54aa\U8179\U90e8\U591a\U4f59\U8102\U80aa\Uff0c\U5f3a\U58ee\U5b9d\U5b9d\U7684\U4e24\U817f\Uff0c\U5b9d\U5b9d\U4e0e\U5988\U5988\U4eb2\U5207\U914d\U5408\Uff0c\U6fc0\U53d1\U5988\U5988\U953b\U70bc\U7684\U5174\U8da3\Uff0c\U589e\U8fdb\U6bcd\U5b50\U7684\U4eb2\U60c5\U3002";
 "active_name" = "\U5988\U54aa\U5b9d\U8d1d\U7ec3\U745c\U4f3d\Uff08\U8239\U5f0f\Uff09";
 "active_num_blog" = 4942;
 "active_num_person" = 11295;
 "active_user" = "2023|/AppCode/TempFace/1.jpg,2024|/AppCode/TempFace/2.jpg,2025|/AppCode/TempFace/3.jpg,2026|/AppCode/TempFace/4.jpg,2027|/AppCode/TempFace/5.jpg,2028|/AppCode/TempFace/6.jpg,2029|/AppCode/TempFace/7.jpg,2030|/AppCode/TempFace/8.jpg,2031|/AppCode/TempFace/9.jpg,2032|/AppCode/TempFace/10.jpg,";
 "active_zhuyi" = "\U5988\U5988\U53ef\U6839\U636e\U81ea\U8eab\U60c5\U51b5\U8fdb\U884c\U52a8\U4f5c\Uff0c\U4e0d\U8981\U5f3a\U6c42\U52a8\U4f5c\U7684\U6807\U51c6\Uff0c\U5b83\U9700\U8981\U5e38\U5e74\U7684\U575a\U6301\U624d\U80fd\U8fbe\U5230\U6548\U679c\U3002";
 "class_id" = 11;
 pic = "/tt_file/class_photo/11/11-1-1-0.jpg|/tt_file/class_photo/11/11-1-2-0.jpg|/tt_file/class_photo/11/11-1-3-0.jpg|/tt_file/class_photo/11/11-1-4-0.jpg|/tt_file/class_photo/11/11-1-5-0.jpg|/tt_file/class_photo/11/11-1-6-0.jpg|/tt_file/class_photo/11/11-1-7-0.jpg|/tt_file/class_photo/11/11-1-8-0.jpg|/tt_file/class_photo/11/11-1-9-0.jpg";
 }
 */
@interface DetailLessionModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (copy, nonatomic) NSString * active_buzhou;
@property (copy, nonatomic) NSString * active_id;
@property (copy, nonatomic) NSString * active_mubiao;
@property (copy, nonatomic) NSString * active_name;
@property (copy, nonatomic) NSString * active_num_blog;
@property (copy, nonatomic) NSString * active_num_person;
@property (copy, nonatomic) NSString * active_user;
@property (copy, nonatomic) NSString * active_zhuyi;
@property (copy, nonatomic) NSString * class_id;
@property (copy, nonatomic) NSString * pic;
+(instancetype)detailLessionModelWithDict:(NSDictionary*)dict;

@end
